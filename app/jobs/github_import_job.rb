class GithubImportJob < ApplicationJob

  def perform(gem_id)
    gem = Gemm.find(gem_id)
    gem.import_github
  end

end
