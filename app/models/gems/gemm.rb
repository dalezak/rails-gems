class Gemm < ApplicationRecord
  self.table_name = "gems"

  include ::Typeable

  # store_attribute :details, :extra, :string

  scope :for_search, ->(query) { where("name ILIKE CONCAT('%', ?, '%') OR title ILIKE CONCAT('%', ?, '%')", sanitize_sql_like(query), sanitize_sql_like(query)) if query.present? }

  def type_name
    "Gem"
  end  

end
