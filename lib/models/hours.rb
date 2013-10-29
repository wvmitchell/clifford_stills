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

    def self.update(day, open, close)
      create_table_if_none
      if db_connection.from(:hours).where(day: day).count >= 1
        adjust_day(day, open, close)
      else
        insert_day(day, open, close)
      end
    end

    def self.create_table_if_none
      unless db_connection.table_exists?(:hours)
        db_connection.create_table :hours do
          primary_key :id
          String :day
          Integer :opens_at
          Integer :closes_at
        end
      end
    end
  end
end
