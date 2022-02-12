json.cache! [@gems], skip_digest: true do
  json.array! @gems, partial: "gems/gem", as: :gem
end