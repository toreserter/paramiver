Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'zui8uknb7XCUemfMIdjuiw', 'gQOYnWbBql9w88ztDHYw7RxZowdgDUnZ27mtaNkgXz8'
  provider :facebook, '471334576228732', 'b6b6ae66a7672db92229cb20f85ec860', {:scope => 'publish_stream,offline_access,email'}
end

