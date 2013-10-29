require 'sequel'

module DB_helper
  def db_connection
    if ENV['rack_env'] == 'test'
      @db_connection ||= Sequel.sqlite('db/database_test')
    else
      @db_connection ||= Sequel.sqlite('db/database_dev')
    end
  end
end

