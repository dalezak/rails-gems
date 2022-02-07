class Gemm < ApplicationRecord
  self.table_name = "gems"

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

  attribute :liked, :boolean

  has_many :likes, dependent: :destroy, class_name: "Gemm", foreign_key: "gem_id"
  has_many :users, through: :likes, dependent: :destroy

  scope :for_search, ->(query) { where("name ILIKE CONCAT('%', ?, '%') OR title ILIKE CONCAT('%', ?, '%')", sanitize_sql_like(query), sanitize_sql_like(query)) if query.present? }

  def type_name
    "Gem"
  end

  def self.import(data)
    name = (data["name"] || data["full_name"]).gsub("-#{data['number']}", "")
    gem = Gemm.find_or_initialize_by(slug: name.parameterize)
    gem.name = name
    gem.title = data["info"] || data["summary"]
    gem.description = data["description"]
    gem.version = data["version"]
    gem.platform = data["platform"]
    gem.downloads_count = data["downloads"].to_i
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

end
