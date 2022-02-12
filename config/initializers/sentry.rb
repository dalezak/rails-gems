if ENV['SENTRY_DSN'].present?
  Sentry.init do |config|
    config.dsn = ENV['SENTRY_DSN']
    config.traces_sample_rate = 0.2
    config.breadcrumbs_logger = [:active_support_logger, :http_logger]
  end
end