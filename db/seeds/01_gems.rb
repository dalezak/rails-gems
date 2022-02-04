Gems.most_downloaded.each do |items|
  data = items.first
  gem = Gemm.find_or_initialize_by(uid: data["id"])
  gem.name = data["full_name"].gsub("-#{data["number"]}", "")
  gem.title = data["summary"]
  gem.description = data["description"]
  gem.size = data["size"]
  gem.version = data["number"]
  gem.authors = data["authors"].split(", ")
  gem.licenses = data["licenses"]
  gem.built_at = data["built_at"]
  gem.created_at = data["created_at"]
  gem.updated_at = data["updated_at"]
  gem.save
  puts gem.inspect
end