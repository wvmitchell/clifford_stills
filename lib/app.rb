require './lib/models/hours'

class ClyffordStillsApp < Sinatra::Base

  set :public, 'public'

  get '/' do
    #index page
  end

  get '/museum' do
    erb :museum
  end

  get '/collection' do
    erb :collection
  end

  get '/building' do
    erb :building
  end

  # ADMIN ROUTES
  get '/admin/hours' do
    #erb :admin_hours
  end

  post '/admin/hours' do
    Database::Hours.update(params[:day], params[:opens_at], params[:closes_at])
    redirect '/admin/hours'
  end

end
