require './lib/models/db_helper'

module Database
  class Programs
    extend DB_helper

    def self.create_table_if_none
      unless db_connection.table_exists?(:programs)
        db_connection.create_table :programs do
          primary_key :id
          String :name
          String :description
          String :instructor
          Date :start_date
          Date :end_date
          Integer :hour
          String :type
        end
      end
    end

    def self.insert(params)
      create_table_if_none
      db_connection.from(:programs).insert(
        name: params[:name],
        description: params[:description],
        instructor: params[:instructor],
        start_date: params[:start_date],
        end_date: params[:end_date],
        hour: params[:hour],
        type: params[:type]
      )
    end

    def self.update(params)
      db_connection.from(:programs).where(id: params[:id]).update(
        name: params[:name],
        description: params[:description],
        instructor: params[:instructor],
        start_date: params[:start_date],
        end_date: params[:end_date],
        hour: params[:hour],
        type: params[:type]
      )
    end

    def self.members_only
      db_connection.from(:programs).where(type: "Member")
    end

    def self.public_only
      db_connection.from(:programs).where(type: "Public")
    end

    def self.instructor(course)
      db_connection.from(:programs).where(name: course).to_a.first[:instructor]
    end

    def self.all
      if db_connection.table_exists?(:programs)
        db_connection.from(:programs)
      else
        []
      end
    end
  end
end
