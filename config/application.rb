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

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsGems
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.time_zone = "UTC"
    config.active_record.default_timezone = :utc
    config.i18n.default_locale = :en
    config.i18n.available_locales = [:en]
    config.i18n.fallbacks = [I18n.default_locale]

    config.eager_load_paths += Dir[Rails.root.join('app', 'jobs', '**/')]
    config.eager_load_paths += Dir[Rails.root.join('app', 'models', '**/')]
    config.autoload_paths += Dir[Rails.root.join('app', 'mailers', '**/')]
  end
end
