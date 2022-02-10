if ENV['REDIS_URL'].present?
  Sidekiq.configure_client do |config|
    config.redis = { url: ENV['REDIS_URL'], size: 1, ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE } }
  end
  Sidekiq.configure_server do |config|
    pool_size = Sidekiq.options[:concurrency] + 2
    config.redis = { url: ENV['REDIS_URL'], size: pool_size, ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE } }
    Rails.application.config.after_initialize do
      ActiveRecord::Base.connection_pool.disconnect!
      ActiveSupport.on_load(:active_record) do
        db_config = Rails.application.config.database_configuration[Rails.env]
        db_config['reaping_frequency'] = ENV['DATABASE_REAP_FREQ'] || 10 # seconds
        db_config['pool'] = pool_size
        ActiveRecord::Base.establish_connection(db_config)
        Rails.logger.info("Sidekiq DB Connection Pool: #{ActiveRecord::Base.connection.pool.instance_variable_get('@size')}")
      end
    end
  end
end