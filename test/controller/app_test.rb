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

end
