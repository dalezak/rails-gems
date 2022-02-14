require "time"
task :sitemap_refresh do
  if Time.now.sunday?
    Rake::Task["sitemap:refresh"].invoke
  end
end