json.cache! [@gem.cache_key_with_version], skip_digest: true do
  json.partial! "gems/gem", gem: @gem
end