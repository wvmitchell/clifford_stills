require './test/test_helper.rb'
require 'sinatra/base'
require 'rack/test'
require'./lib/app'

class ClyffordStillsAppTest < MiniTest::Test
  include Rack::Test::Methods

  def app
    ClyffordStillsApp
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

end
