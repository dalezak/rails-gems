namespace :gems do
  desc "Gems refresh"
  task refresh: :environment do
    GemsRefreshJob.perform_later
  end
end