namespace :db do
  desc "Drop, Create, Migrate, Seed"
  task :recreate do
    if Rails.env.development?
      puts "delete storage"
      FileUtils.rm_rf(Dir.glob(Rails.root.join('storage', '*')))
      
      puts "delete uploads"
      FileUtils.rm_rf(Dir.glob(Rails.root.join('public', 'uploads', '*')))
      
      puts "rake db:drop"
      Rake::Task["db:drop"].invoke

      puts "rake db:create"
      Rake::Task["db:create"].invoke

      if File.exist?('db/schema.rb')
        puts "File.delete('db/schema.rb')"
        File.delete('db/schema.rb')
      end

      puts "rake db:migrate"
      Rake::Task["db:migrate"].invoke
      
      puts "rake db:reset"
      Rake::Task["db:reset"].invoke
    else
      puts "Environment NOT Development, exiting..."
    end
  end
end
