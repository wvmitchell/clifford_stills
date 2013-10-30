require './lib/models/db_helper'

module Database
  class Contact
    extend DB_helper

    def self.create_table_if_none
      unless db_connection.table_exists?(:contact)
        db_connection.create_table :contact do
          primary_key :id
          String :name
          String :email
          String :issue
        end
      end
    end

    def self.insert(params)
      create_table_if_none
      db_connection.from(:contact).insert(
        name: params[:name],
        email: params[:email],
        issue: params[:issue]
        )
    end

    def self.email(name)
      db_connection.from(:contact).where(:name => name).to_a.first[:email]
    end



  end
end
