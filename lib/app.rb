class ClyffordStillsApp < Sinatra::Base

  set :public, 'public'

  get '/' do
    erb :index
  end

  get '/collection' do
    erb :collection
  end

end
