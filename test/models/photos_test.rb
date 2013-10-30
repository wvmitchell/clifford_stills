require './test/test_helper.rb'
require './lib/models/photos'

class PhotosTest < MiniTest::Unit::TestCase

  attr_reader :db

  def setup
    @db = Database::Photos.db_connection
    Database::Photos.create_table_if_none
  end

  def teardown
    db.drop_table(:photos)
  end

  def test_it_exists
    assert Database::Photos
  end

  def test_it_can_add_a_new_photo
    Database::Photos.create({filename: 'happy.jpg'})
    assert_equal 'happy.jpg', db.from(:photos).first[:filename]
  end

  def test_it_can_update_a_photo
    Database::Photos.create({filename: 'happy.jpg'})
    Database::Photos.update({id: 1, filename: 'sad.jpg'})
    assert_equal 'sad.jpg', db.from(:photos).first[:filename]
  end

end

