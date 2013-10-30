require './test/test_helper'
require './lib/models/contact_us'

class ContactTest < Minitest::Test

  attr_reader :db

  def setup
    Database::Contact.create_table_if_none
    @db = Database::Contact.db_connection.from(:contact)
  end

  def teardown
    Database::Contact.db_connection.drop_table(:contact)
  end

  def test_it_exists
    assert Database::Contact
  end

  def test_it_adds_a_new_record_to_db
    params = {name: "Will Mitchell", email: "will@example.com", issue: "Broken site"}
    Database::Contact.insert(params)
    assert_equal 'will@example.com', Database::Contact.email('Will Mitchell')
  end

end
