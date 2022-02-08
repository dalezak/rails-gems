["rails", "devise", "cancancan", "omniauth", "shrine", "pg", "puma", "turbo-rails", "jbuilder", "redis", "turbo-rails", "cssbundling-rails", "jsbundling-rails", "rubocop"].each do |name|
  data = Gems.info name
  gem = Gemm.import data
  puts gem.inspect
end
Gems.most_downloaded.each do |items|
  item = items.first
  name = (item["name"] || item["full_name"]).gsub("-#{item['number']}", "")
  data = Gems.info name
  gem = Gemm.import data
  puts gem.inspect
end