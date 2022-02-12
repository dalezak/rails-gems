json.cache! [@tags], skip_digest: true do
  json.array! @tags, partial: "tags/tag", as: :tag
end