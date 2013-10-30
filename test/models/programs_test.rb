require './test/test_helper'
require './lib/models/programs'

class ProgramsTest < Minitest::Test

  attr_reader :db

  def setup
    Database::Programs.create_table_if_none
    @db = Database::Programs.db_connection.from(:programs)
  end

  def teardown
    Database::Programs.db_connection.drop_table(:programs)
  end

  def test_it_exists
    assert Database::Programs
  end

  def test_it_adds_a_new_record_to_db
    params = {name: 'Painting', description: 'How to paint', instructor: 'bob'}
    Database::Programs.insert(params)
    assert_equal 'Painting', db.where(name: 'Painting').limit(1).first[:name]
  end

  def test_it_updates_a_record_in_db
    params = {name: 'Painting', description: 'How to paint', instuctor: 'bob'}
    Database::Programs.insert(params)
    new_params = {id:1, name: 'Painting', description: 'Why to paint'}
    Database::Programs.update(new_params)
    assert_equal "Why to paint", db.where(id: 1).first[:description]
  end

  def test_it_returns_only_member_programs
    Database::Programs.insert({name: 'Draw', type: 'Member'})
    Database::Programs.insert({name: 'Paint', type: 'Public'})
    Database::Programs.members_only.each do |program|
      assert_equal 'Member', program[:type]
    end
  end

  def test_it_returns_only_public_programs
    Database::Programs.insert({name: 'Draw', type: 'Member'})
    Database::Programs.insert({name: 'Paint', type: 'Public'})
    Database::Programs.public_only.each do |program|
      assert_equal 'Public', program[:type]
    end
  end

  def test_instructor_method
    params = {name: 'Painting', description: 'How to paint', instructor: 'bob'}
    Database::Programs.insert(params)
    assert_equal 'bob', Database::Programs.instructor('Painting')
  end
end
