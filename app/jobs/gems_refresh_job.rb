class GemsRefreshJob < ApplicationJob

  def perform
    Gemm.find_each do |gem|
      data = Gems.info(gem.name)
      Gemm.import(data)
    end
    true
  end

end
