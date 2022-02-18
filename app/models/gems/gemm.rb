# == Schema Information
#
# Table name: gems
#
#  id              :uuid             not null, primary key
#  type            :string           default("Gemm")
#  slug            :string
#  name            :string
#  title           :text
#  description     :text
#  version         :string
#  platform        :string
#  details         :jsonb            default("{}")
#  authors         :jsonb            default("{}"), is an Array
#  licenses        :jsonb            default("{}"), is an Array
#  tags_count      :integer          default("0")
#  likes_count     :integer          default("0")
#  downloads_count :integer          default("0")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_gems_on_slug  (slug)
#

class Gemm < ApplicationRecord
  self.table_name = "gems"

  after_create :add_tags
  after_create :import_github_job

  include ::Typeable
  include ::Slugable

  store_attribute :details, :homepage_uri, :string
  store_attribute :details, :project_uri, :string
  store_attribute :details, :funding_uri, :string
  store_attribute :details, :wiki_uri, :string
  store_attribute :details, :source_code_uri, :string
  store_attribute :details, :documentation_uri, :string
  store_attribute :details, :bug_tracker_uri, :string
  store_attribute :details, :mailing_list_uri, :string

  has_many :likes, inverse_of: :gem, dependent: :destroy, foreign_key: "gem_id"
  has_many :users, through: :likes, dependent: :destroy

  has_many :taggings, inverse_of: :gem, dependent: :destroy, foreign_key: "gem_id"
  has_many :tags, through: :taggings

  scope :for_slug, ->(slug) { where(slug: slug) }
  scope :for_user, ->(user) { joins(:likes).where(likes: { user_id: user.id }) if user.present? }
  scope :for_tag, ->(tag) { joins(:taggings).where(taggings: { tag_id: tag.id }) if tag.present? }
  scope :for_search, ->(query) { where("name ILIKE CONCAT('%', ?, '%') OR title ILIKE CONCAT('%', ?, '%')", sanitize_sql_like(query), sanitize_sql_like(query)) if query.present? }

  scope :with_tags, ->(include) { includes(:tags) if include.present? && include.to_bool }

  validates :name, presence: true
  validates :slug, presence: true

  def type_name
    "Gem"
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").joins(:taggings).group("taggings.tag_id")
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip.downcase).first_or_create!
    end
  end

  def hash_tags(separator=' ')
    tags.map{|tag| "##{tag.name.strip.downcase}"}.join(separator)
  end

  def add_tags
    Tag.all_cached.each do |tag|
      if tag.synonym?(self.title) && self.tags.exists?(tag.id) == false
        self.taggings.create(tag_id: tag.id)
      end
    end
  end

  def self.import_rubygems(data)
    if data.present? && data["name"].present?
      gem = Gemm.find_or_initialize_by(slug: data["name"].parameterize)
      gem.import_rubygems(data)
    end
  end

  def import_rubygems(data = nil)
    if self.slug.present?
      begin
        data ||= Gems.info(self.slug)
        self.name = data["name"]
        self.title = data["info"]
        self.description = data["description"]
        self.version = data["version"]
        self.platform = data["platform"]
        self.downloads_count = data["downloads"].to_i
        self.authors = data["authors"].split(", ")
        self.licenses = data["licenses"]
        self.homepage_uri = data["homepage_uri"]
        self.project_uri = data["project_uri"]
        self.funding_uri = data["funding_uri"]
        self.wiki_uri = data["wiki_uri"]
        self.source_code_uri = data["source_code_uri"]
        self.documentation_uri = data["documentation_uri"]
        self.bug_tracker_uri = data["bug_tracker_uri"]
        self.mailing_list_uri = data["mailing_list_uri"]
        self.save! if self.changed? || self.persisted? == false
      rescue => exception
        Rails.logger.error "Gemm#import_rubygems exception #{exception}"
      end
    end
    self
  end

  def self.import_github
    Gemm.find_each do |gem|
      gem.import_github
    end
  end

  def import_github
    if self.homepage_uri.to_s.start_with?("https://github.com/")
      begin
        path = self.homepage_uri.to_s.gsub("https://github.com/", "")
        client = Octokit::Client.new(access_token: ENV['GITHUB_ACCESS_TOKEN'])
        repo = client.repo(path)
        self.forks_count = repo.forks_count
        self.watchers_count = repo.watchers_count
        self.stars_count = repo.subscribers_count
        self.save! if self.changed?
      rescue => exception
        Rails.logger.error "Gemm#import_github exception #{exception}"
      end
    end
    self
  end

  def import_github_job
    GithubImportJob.perform_later self.id if Rails.env.production?
  end

end