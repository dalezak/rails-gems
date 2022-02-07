["rails", "devise", "cancancan", "omniauth", "shrine", "pg", "puma", "turbo-rails", "jbuilder", "redis", "turbo-rails", "cssbundling-rails", "jsbundling-rails", "rubocop"].each do |name|
  data = Gems.info name
  Gemm.import data
end
Gems.most_downloaded.each do |items|
  data = items.first
  Gemm.import data
end