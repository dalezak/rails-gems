json.cache! [@users], skip_digest: true do
  json.array! @users, partial: "users/user", as: :user
end