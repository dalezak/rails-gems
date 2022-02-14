class Rack::Attack
  class Request < ::Rack::Request
    def params(*args)
      @params ||= ActionDispatch::Request.new(env).params(*args)
    end
    def remote_ip
      @remote_ip ||= (env['action_dispatch.remote_ip'] || env['HTTP_X_FORWARDED_FOR'] || ip).to_s
    end
  end
end
Rack::Attack.safelist('safelist localhost') do |req|
  req.ip == '127.0.0.1' || req.ip == '::1'
end
Rack::Attack.throttle 'throttle logins', limit: 5, period: 1.hour do |req|
  if req.post? && (req.path == '/users/sign_in' || req.path == '/users/sign_in.json')
    req.params['email'].to_s.downcase.gsub(/\s+/, "").presence
  end
end
Rack::Attack.throttle 'throttle signups', limit: 2, period: 1.hour do |req|
  if req.post? && (req.path == '/users/sign_up' || req.path == '/users/sign_up.json')
    req.params['email'].to_s.downcase.gsub(/\s+/, "").presence
  end
end
Rack::Attack.throttle 'throttle password resets', limit: 2, period: 1.hour do |req|
  if req.post? && (req.path == '/users/password' || req.path == '/users/password.json')
    req.params['email'].to_s.downcase.gsub(/\s+/, "").presence
  end
end
Rack::Attack.blocklist 'blocklist fail2ban pentesters' do |req|
  Rack::Attack::Fail2Ban.filter "pentesters-#{req.ip}", maxretry: 2, findtime: 1.hour, bantime: 1.day do
    CGI.unescape(req.query_string) =~ %r{/etc/passwd} ||
      req.path.include?('/etc/passwd') ||
      req.path.include?('wp-admin') ||
      req.path.include?('wp-login') ||
      req.path.include?('wp-content') ||
      req.path.include?('wp-includes') ||
      req.path.include?('/wordpress') ||
      req.path.include?('/site') ||
      req.path.include?('/cms') ||
      req.path.include?('tar.gz') ||
      req.path.include?('.zip') ||
      req.path.include?('.php') ||
      req.path.include?('.env') ||
      req.path.include?('.git') ||
      req.path.include?('.aspx') ||
      req.path.include?('.db') ||
      req.path.include?('.ini') ||
      req.path.include?('.7z') ||
      req.path.include?('.rar') ||
      req.path.include?('.key') ||
      req.path.include?('.cgi') ||
      req.path.include?('.ssh') ||
      req.path.include?('.sql') ||
      req.path.include?('.swf') ||
      req.path.include?('.cfm') ||
      req.path.include?('.config') ||
      req.path.include?('.sqlite') ||
      req.path.include?('ht.access') ||
      req.path.include?('installed.json') ||
      req.path.include?('.gem/credentials')
  end
end
