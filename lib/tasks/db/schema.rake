Rake::Task["assets:precompile"].enhance do
  unless Rails.env.development? || Rails.env.test?
    puts "rake db:migrate..."
    Rake::Task["db:migrate"].invoke
    puts "db:schema:cache:dump..."
    Rake::Task["db:schema:cache:dump"].invoke
  end
end
