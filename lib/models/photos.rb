require './lib/models/db_helper'

module Database
  class Photos
    extend DB_helper

    def self.create(params)
      create_table_if_none
      db_connection.from(:photos).insert(params)
    end

    def self.update(params)
      db_connection.from(:photos).where(id: params[:id]).update(params)
    end

    def self.first
      db_connection.from(:photos).first
    end

    def self.all
      if db_connection.table_exists?(:photos)
        db_connection.from(:photos).to_a
      else
        []
      end
    end

    def self.create_table_if_none
      unless db_connection.table_exists?(:photos)
        db_connection.create_table :photos do
          primary_key :id
          String :filename
        end
      end
    end
  end
end
