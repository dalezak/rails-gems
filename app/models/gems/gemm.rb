class Gemm < ApplicationRecord
  self.table_name = "gems"

  include ::Typeable

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

end
