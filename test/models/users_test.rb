require './test/test_helper.rb'
require './lib/models/users'

class UsersTest < MiniTest::Unit::TestCase

  attr_reader :db

  def setup
    @db = Database::Users.db_connection
    Database::Users.create_table_if_none
  end

  def teardown
    db.drop_table(:users)
  end

  def test_it_exists
    assert Database::Users
  end

  def test_it_creates_a_new_user
    pass = Digest::SHA2.hexdigest('secret_password')
    params = {name: 'Will', email: 'wvm@wvm.com', hashed_password: pass}
    Database::Users.create(params)
    assert_equal 'Will', Database::Users.first[:name]
    pass2 = Digest::SHA2.hexdigest('secret_password')
    assert_equal pass2, Database::Users.first[:hashed_password]
  end

end
