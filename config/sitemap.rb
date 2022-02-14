if Rails.env.production?
  SitemapGenerator::Sitemap.create_index = true
  SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
  SitemapGenerator::Sitemap.default_host = ENV['APP_URL']
  SitemapGenerator::Sitemap.adapter = SitemapGenerator::AwsSdkAdapter.new(
    ENV['AWS_BUCKET_NAME'],
    region: ENV['AWS_REGION'],
    access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'])
  SitemapGenerator::Sitemap.create do
    add home_path, priority: 0.9, changefreq: 'weekly'
    add gems_path, priority: 0.8, changefreq: 'weekly'
    Gemm.find_each do |gemm|
      add gem_path(gemm), priority: 0.8, changefreq: 'weekly', lastmod: gemm.updated_at
    end
    add users_path, priority: 0.8, changefreq: 'weekly'
    User.find_each do |user|
      add user_path(user), priority: 0.8, changefreq: 'weekly', lastmod: user.updated_at
    end
    add tags_path, priority: 0.6, changefreq: 'weekly'
    Tag.find_each do |tag|
      add tag_path(tag), priority: 0.6, changefreq: 'monthly', lastmod: tag.updated_at
    end
  end
end