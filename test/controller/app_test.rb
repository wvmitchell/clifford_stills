require './test/test_helper.rb'
require 'sinatra/base'
require 'rack/test'
require './lib/app'
require './lib/models/hours'
require './lib/models/programs'

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

  def test_admin_programs_page_exists
    get '/admin/programs'
    assert last_response.ok?
  end

  def test_admin_programs_changes_table
    skip
    description = 'Terrible Program that does not help'
    instructor = 'Batman'
    Database::Programs.create_table_if_none
    post '/admin/hours', :name => 'Best Program',
                         :description => 'Awesome programs where you and your whole family can interact',
                         :instructor => 'Scuba Steve',
                         :start_date => 10-31-13,
                         :end_date => 11-15-13,
                         :hour => 24
    assert_equal 'Scuba Steve', Database::Programs.instructor('Best Program')
  end

  def test_programs_page_exists
    get '/programs'
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

  def test_photo_gallery_page_exists
    get '/photo_gallery'
    assert last_response.ok?
  end

  def test_admin_photos_page_exists
    get 'admin/photo_gallery'
    assert last_response.ok?
  end

end
