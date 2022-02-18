require_relative "boot"

# require "rails/all"
require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module RailsGems
  class Application < Rails::Application
    config.load_defaults 7.0

    config.time_zone = "UTC"
    config.active_record.default_timezone = :utc
    config.i18n.default_locale = :en
    config.i18n.available_locales = [:en]
    config.i18n.fallbacks = [I18n.default_locale]

    config.eager_load_paths += Dir[Rails.root.join('app', 'jobs', '**/')]
    config.eager_load_paths += Dir[Rails.root.join('app', 'models', '**/')]
    config.autoload_paths += Dir[Rails.root.join('app', 'mailers', '**/')]

    credentials.config.each do |key, value|
      if key.to_s == Rails.env.to_s
        value.each do |env_key, env_value|
          ENV[env_key.to_s.upcase] = env_value.to_s if ENV[env_key.to_s.upcase].blank?
          ENV[env_key.to_s.downcase] = env_value.to_s if ENV[env_key.to_s.downcase].blank?
        end
      elsif ['development', 'staging', 'test', 'production'].include?(key.to_s) == false
        ENV[key.to_s.upcase] = value.to_s if ENV[key.to_s.upcase].blank?
        ENV[key.to_s.downcase] = value.to_s if ENV[key.to_s.downcase].blank?
      end
    end
  end
end
