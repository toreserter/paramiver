class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    auth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])
    if authentication
      flash[:notice] = "Kullanici giris yapti."
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user     # daha önce farklı bir provider ile login olmuş. Yeni provider kaydını yapacağız.
      current_user.authentications.create(:provider => auth['provider'], :uid => auth['uid'])
      flash[:notice] = "Basariyla giris yapildi."
      redirect_to authentications_url
    else    #eger signout durumunda ilk kez o account ile giris yapılıyorsa
      user = User.new
      user.apply_oauth(auth)
      if user.save
        flash[:notice] = "Kullanici giris yapti."
        sign_in_and_redirect(:user, user)
      else
        session[:omniauth] = auth.except('extra')
        redirect_to new_user_registration_path
      end
    end
  end
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    redirect_to authentications_url, :notice => "Successfully destroyed authentication."
  end

end
