require './lib/models/db_helper'

module Database
  class Users
    extend DB_helper

    def self.create_table_if_none
      unless db_connection.table_exists?(:users)
        db_connection.create_table :users do
          primary_key :id
          String :name
          String :email
          String :hashed_password
          Date :birthday
        end
      end
    end

    def self.create(params)
      create_table_if_none
      db_connection.from(:users).insert(params)
    end

    def self.first
      db_connection.from(:users).first
    end


  end
end
