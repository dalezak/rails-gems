json.cache! [@tag.cache_key_with_version], skip_digest: true do
  json.partial! "tags/tag", tag: @tag
end