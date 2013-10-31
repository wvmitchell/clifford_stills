require './test/test_helper'
require './lib/models/programs'

class ProgramsTest < Minitest::Test

  attr_reader :db, :required_params

  def setup
    Database::Programs.create_table_if_none
    @db = Database::Programs.db_connection.from(:programs)
    @required_params = {name: 'Painting', 
                       description: 'How to paint', 
                       instructor: 'bob',
                       start_date: 10-10-2013,
                       end_date: 10-20-2013}
  end

  def teardown
    Database::Programs.db_connection.drop_table(:programs)
  end

  def test_it_exists
    assert Database::Programs
  end

  def test_it_adds_a_new_record_to_db
    Database::Programs.insert(required_params)
    assert_equal 'Painting', db.where(name: 'Painting').limit(1).first[:name]
  end

  def test_it_updates_a_record_in_db
    params = {name: 'Painting', description: 'How to paint', instuctor: 'bob'}
    Database::Programs.insert(required_params)
    new_params = required_params.merge({id:1, name: 'Painting', description: 'Why to paint'})
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
    Database::Programs.insert(required_params)
    assert_equal 'bob', Database::Programs.instructor('Painting')
  end

  def test_insert_method_is_dependent_upon_having_name
    required_params.delete(:name)
    Database::Programs.insert(required_params)
    assert_equal 0, db.where(description: 'How to paint').count
  end

  def test_insert_method_is_dependent_upon_having_name_filled_in
    required_params[:name] = ""
    Database::Programs.insert(required_params)
    assert_equal 0, db.where(description: 'How to paint').count
  end

  def test_insert_method_returns_true_or_false
    assert_equal true, Database::Programs.insert(required_params)
    required_params[:name] = ""
    assert_equal false, Database::Programs.insert(required_params)
    required_params.delete(:name)
    assert_equal false, Database::Programs.insert(required_params)
  end

  def test_insert_method_is_dependent_on_start_date
    required_params.delete(:start_date)
    assert_equal false, Database::Programs.insert(required_params)
  end

  def test_insert_method_is_dependent_on_end_date
    required_params.delete(:end_date)
    assert_equal false, Database::Programs.insert(required_params)
  end





end
