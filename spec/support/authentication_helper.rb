def authentication
  user = 'admin'
  password = 'secret'
  request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user, password)
end
