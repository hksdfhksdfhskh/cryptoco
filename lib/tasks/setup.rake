namespace :setup do
  desc "Create the database, load schema and import initial & sample data"
  task all: :environment do
    Rake::Task['db:create'].invoke if Rails.env.development?
    Rake::Task['db:schema:load'].invoke
    Rake::Task['db:seed'].invoke
    puts "Setup has been done"
  end
end