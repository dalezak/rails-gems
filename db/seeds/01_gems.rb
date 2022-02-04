["rails", "devise", "cancancan", "omniauth", "shrine", "pg", "puma", "turbo-rails", "jbuilder", "redis", "turbo-rails", "cssbundling-rails", "jsbundling-rails"].each do |name|
  data = Gems.info name
  gem = Gemm.find_or_initialize_by(name: data["name"])
  gem.name = data["name"]
  gem.title = data["info"] || data["summary"]
  gem.description = data["description"]
  gem.size = data["size"].to_i
  gem.version = data["version"]
  gem.platform = data["platform"]
  gem.downloads = data["downloads"].to_i
  gem.authors = data["authors"].split(", ")
  gem.licenses = data["licenses"]
  gem.homepage_uri = data["homepage_uri"]
  gem.project_uri = data["project_uri"]
  gem.funding_uri = data["funding_uri"]
  gem.wiki_uri = data["wiki_uri"]
  gem.source_code_uri = data["source_code_uri"]
  gem.documentation_uri = data["documentation_uri"]
  gem.bug_tracker_uri = data["bug_tracker_uri"]
  gem.mailing_list_uri = data["mailing_list_uri"]
  gem.built_at = data["built_at"] if data["built_at"].present?
  gem.created_at = data["created_at"] if data["created_at"].present?
  gem.updated_at = data["updated_at"] if data["updated_at"].present?
  gem.save
end
# Gems.most_downloaded.each do |items|
#   data = items.first
  # gem = Gemm.find_or_initialize_by(uid: data["id"])
  # gem.name = (data["name"] || data["full_name"]).gsub("-#{data["number"]}", "")
  # gem.title = data["summary"]
  # gem.description = data["description"]
  # gem.size = data["size"].to_i
  # gem.version = data["number"]
  # gem.downloads = data["downloads"].to_i
  # gem.authors = data["authors"].split(", ")
  # gem.licenses = data["licenses"]
  # gem.funding_uri = data["funding_uri"]
  # gem.homepage_uri = data["homepage_uri"]
  # gem.project_uri = data["project_uri"]
  # gem.funding_uri = data["funding_uri"]
  # gem.built_at = data["built_at"]
  # gem.created_at = data["created_at"]
  # gem.updated_at = data["updated_at"]
  # gem.save
#   puts gem.inspect
# end