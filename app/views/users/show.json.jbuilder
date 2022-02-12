json.cache! [@user.cache_key_with_version], skip_digest: true do
  json.partial! "users/user", user: @user
end