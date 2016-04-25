namespace :db do

  desc 'create a copy of the production database'
  task :dump => :environment do
    config_file = YAML.load_file('config/database.yml')
    config = config_file[Rails.env]

    stamp = Time.now.strftime("%Y%m%d%H%M")

    if config
      puts "creating public/#{stamp}.sql"
      `mysqldump #{config['database']} -u#{config['username']} -p#{config['password']} > public/#{stamp}.sql`
    end
  end

  namespace :dev do

    desc "run after importing production so things will go smoothly"
    task :sanitize => :environment do
      Q.tell %|UPDATE employees SET profile_file_name = NULL, profile_content_type = NULL, profile_file_size = NULL|
    end


    desc 'load last sql file to dev'
    task :load => :environment do

      file = `find sql/ -maxdepth 1 -type f | sort | tail -n 1`

      config_file = YAML.load_file('config/database.yml')
      config = config_file['development']

      if config 
        puts "loading #{file}"
        `mysql #{config['database']} -u#{config['username']} -p#{config['password']} < #{file}`
      end
    end
  end
end            

