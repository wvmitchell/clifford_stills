class ClyffordStillsApp < Sinatra::Base

  set :public, 'public'

  get '/' do
    #index page
  end

  get '/museum' do
    erb :index
  end

  get '/collection' do
    erb :collection
  end

  get '/building' do
    erb :building
  end

end
