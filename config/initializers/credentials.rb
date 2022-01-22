Rails.application.credentials.config.each do |key, value|
  ENV[key.to_s.upcase] = value.to_s
  ENV[key.to_s.downcase] = value.to_s
end