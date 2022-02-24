if defined?(LetterOpener)
  LetterOpener.configure do |config|
    config.message_template = :default
    config.location = Rails.root.join('tmp', 'mailers')
  end
end