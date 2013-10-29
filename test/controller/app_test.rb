require './test/test_helper.rb'
require 'sinatra/base'
require 'rack/test'
require './lib/app'
require './lib/models/hours'

class ClyffordStillsAppTest < MiniTest::Test
  include Rack::Test::Methods

  def app
    ClyffordStillsApp
  end

  def teardown
    if Database::Hours.db_connection.table_exists?(:hours)
      Database::Hours.db_connection.drop_table(:hours)
    end
  end

  def test_index
    get '/'
    assert last_response.ok?
  end

  def test_collection_route
    get '/collection'
    assert last_response.ok?
  end

  def test_museum_route
    get '/museum'
    assert last_response.ok?
  end

  def test_building_route
    get '/building'
    assert last_response.ok?
  end

  def test_admin_hours_page_exists
    get '/admin/hours'
    assert last_response.ok?
  end

  def test_admin_hours_changes_table
    open = 5
    close = 18
    Database::Hours.create_table_if_none
    post '/admin/hours', :day => 'Monday', :opens_at => open, :closes_at => close
    assert_equal open, Database::Hours.opening_time('Monday')
  end

  def test_hours_page_exists
    get '/hours'
    assert last_response.ok?
  end

  def test_directions_page_exists
    get '/directions'
    assert last_response.ok?
  end
end
