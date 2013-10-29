require './test/test_helper.rb'
require './lib/models/hours'

class HoursTest < MiniTest::Unit::TestCase

  attr_reader :db

  def setup
    @db = Database::Hours.db_connection
    Database::Hours.create_table_if_none
  end

  def teardown
    db.drop_table(:hours)
  end

  def test_it_exists
    assert Database::Hours
  end

  def test_table_hours_exists
    assert db.table_exists?(:hours)
  end

  def test_insert_day
    Database::Hours.insert_day('Monday', 6, 17)
    assert_equal 6, Database::Hours.opening_time("Monday")
  end

  def test_table_can_adjust_day
    Database::Hours.insert_day("Monday", 6, 8)
    Database::Hours.adjust_day('Monday', 8, 18)
    assert_equal 8, Database::Hours.opening_time("Monday")
  end

  def test_update_method
    Database::Hours.update("Monday", 8, 8)
    assert_equal 8, Database::Hours.opening_time("Monday")
    Database::Hours.update("Monday", 9, 8)
    assert_equal 9, Database::Hours.opening_time("Monday")
  end
end
