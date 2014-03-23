  namespace :db do
    desc "Populate empty database from csv file"
    task :first_seed => :environment do
      abcs = ActiveRecord::Base.configurations
      ActiveRecord::Base.establish_connection(abcs[RAILS_ENV])
      ActiveRecord::Base.connection.recreate_database(ActiveRecord::Base.connection.current_database)
    end


    desc "Update database with "
    task : => : do

    end
  end
