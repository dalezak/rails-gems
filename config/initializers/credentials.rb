Rails.application.credentials.config.each do |key, value|
  if key.to_s == Rails.env
    value.each do |env_key, env_value|
      ENV[env_key.to_s.upcase] = env_value.to_s if ENV[env_key.to_s.upcase].blank?
      ENV[env_key.to_s.downcase] = env_value.to_s if ENV[env_key.to_s.downcase].blank?
    end  
  else
    ENV[key.to_s.upcase] = value.to_s if ENV[key.to_s.upcase].blank?
    ENV[key.to_s.downcase] = value.to_s if ENV[key.to_s.downcase].blank?
  end
end
