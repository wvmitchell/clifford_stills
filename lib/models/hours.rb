require 'sequel'

module Database
  class Hours

    def self.db_connection
      if ENV['rack_env'] == 'test'
        @db_connection ||= Sequel.sqlite('db/database_test')
      else
        @db_connection ||= Sequel.sqlite('db/database_dev')
      end
    end

    def self.insert_day(day, open, close)
      db_connection.from(:hours).insert(day: day, opens_at: open, closes_at: close)
    end

    def self.opening_time(day)
      db_connection.from(:hours).where(day: day).to_a.first[:opens_at]
    end

    def self.adjust_day(day, open, close)
      db_connection.from(:hours).where(:day => day).update(:opens_at => open, :closes_at => close)
    end

  end
end
