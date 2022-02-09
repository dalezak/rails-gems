if Rails.env.development?
  MAX_LOG_SIZE = 2.megabytes
  logs = Dir[File.join(Rails.root, 'log', '*.log')]
  logs.each do |log|
    log_size = File.size?(log).to_i
    if log_size > MAX_LOG_SIZE
      Rails.logger.debug { "Removing Log: #{log}" }
      `rm #{log}`
    end
  end
end
