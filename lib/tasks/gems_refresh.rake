namespace :gems do
  desc "Gems refresh"
  task refresh: :environment do
    Gemm.find_each do |gem|
      gem.import_github
      gem.import_rubygems
      sleep(1.seconds)
    end
  end
end