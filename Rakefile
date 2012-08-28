require './environment.rb'

ActiveRecord::Migrator.migrations_paths = [File.join(File.expand_path(APP_DIR), 'migrations')]

namespace :db do
  desc "Migrate the database"
  task :migrate do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths)
  end

  desc "Create the database"
  task :create do
    config = ActiveRecord::Base.connection_config
    mysql_config = {
      :charset   => 'utf8',
      :collation => 'utf8_unicode_ci'
    }
    ActiveRecord::Base.establish_connection(config.merge(:database => nil))
    ActiveRecord::Base.connection.create_database(config[:database], mysql_config)
    ActiveRecord::Base.establish_connection(config)
  end

  desc "Drop the database"
  task :drop do
    config = ActiveRecord::Base.connection_config
    ActiveRecord::Base.establish_connection(config.merge(:database => nil))
    ActiveRecord::Base.connection.drop_database config[:database]
  end

  desc "Create migration file"
  task :create_migration do
    raise 'Usage: rake db:create_migration NAME=my_migration' unless ENV['NAME']
    filename = [Time.now.utc.strftime('%Y%m%d%H%M%S'), ENV['NAME']].join('_') + '.rb'
    path     = File.join(File.expand_path(APP_DIR), 'migrations', filename)
    klass    = ENV['NAME'].split('_').map(&:capitalize).join('')

    raise 'File already exists' if File.exists?(path)
    f = File.new(path, 'w')
    f.write <<-EOF.gsub(/[^\S\n]{6}/, '').strip
      class #{klass} << ActiveRecord::Migration
        def change
          # Migration goes here.
        end
      end
    EOF
    f.close
    puts "Created #{path}"
  end
end