# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

run Rails.application
if Rails.env.development?
  Rails.application.config.after_initialize do
    port = begin
      Rails::Server::Options.new.parse!(ARGV)[:Port] || 3000
    rescue
      3000
    end
    `open http://localhost:#{port}`
  end
end
Rails.application.load_server
