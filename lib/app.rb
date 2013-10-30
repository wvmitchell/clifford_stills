require './lib/models/hours'
require './lib/models/programs'

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

  get '/hours' do
    if Database::Hours.db_connection.table_exists?(:hours)
      days = Database::Hours.db_connection.from(:hours)
    else
      days = []
    end
    erb :hours, locals: {days: days}
  end

  get '/directions' do
    erb :directions
  end

  get '/clyfford-still' do
    erb :clyfford_still
  end

  get '/programs' do
    programs = Database::Programs.all
    erb :programs, locals: {programs: programs}
  end

  # ADMIN ROUTES
  get '/admin/hours' do
    erb :admin_hours
  end

  post '/admin/hours' do
    Database::Hours.update(params[:day], params[:opens_at], params[:closes_at])
    redirect '/admin/hours'
  end

  get '/admin/programs' do
    erb :admin_programs
  end

  post '/admin/programs' do
    Database::Programs.update(params[:name],
                              params[:description],
                              params[:instructor],
                              params[:start_date],
                              params[:end_date],
                              params[:hour],
                              params[:type])
    redirect '/admin/programs'
  end

end
