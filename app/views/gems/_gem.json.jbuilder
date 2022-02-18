json.extract! gem,
              :id, :slug, :name, :title, :version, :platform, :authors, :licenses,
              :homepage_uri, :project_uri, :funding_uri, :wiki_uri, :source_code_uri, :documentation_uri, :bug_tracker_uri, :mailing_list_uri,
              :tags_count, :likes_count, :stars_count, :downloads_count, :forks_count, :watchers_count,
              :created_at, :updated_at
json.tags gem.tags.map(&:name)