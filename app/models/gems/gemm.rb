class Gemm < ApplicationRecord
  self.table_name = "gems"

  include ::Typeable

  # store_attribute :details, :extra, :string

  attribute :liked, :boolean

  has_many :likes, dependent: :destroy, class_name: "Gemm", foreign_key: "gem_id"
  has_many :users, inverse_of: :like, through: :likes, dependent: :destroy

  scope :for_search, ->(query) { where("name ILIKE CONCAT('%', ?, '%') OR title ILIKE CONCAT('%', ?, '%')", sanitize_sql_like(query), sanitize_sql_like(query)) if query.present? }

  def type_name
    "Gem"
  end  

end
