class ClyffordStillsApp < Sinatra::Base

  set :public, 'public'

  get '/museum' do
    erb :index
  end

  get '/collection' do
    erb :collection
  end

  get '/museum/about-building' do 
    erb :building
  end

end
