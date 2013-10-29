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
    Database::Hours.insert_day('Monday', Time.new(6), Time.new(17))
    assert_equal Time.new(6), Database::Hours.opening_time("Monday")
  end

  def test_table_can_adjust_day
    Database::Hours.insert_day("Monday", Time.new(6), Time.new(8))
    Database::Hours.adjust_day('Monday', Time.new(8), Time.new(18))
    assert_equal Time.new(8), Database::Hours.opening_time("Monday")
  end

  def test_update_method
    Database::Hours.update("Monday", Time.new(8), Time.new(8))
    assert_equal Time.new(8), Database::Hours.opening_time("Monday")
    Database::Hours.update("Monday", Time.new(9), Time.new(8))
    assert_equal Time.new(9), Database::Hours.opening_time("Monday")
  end
end
