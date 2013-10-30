require 'pony'
require './lib/models/hours'
require './lib/models/programs'
require './lib/models/contact_us'

class ClyffordStillsApp < Sinatra::Base

  set :public, 'lib/public'

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
    Database::Programs.insert(params[:program])
    redirect '/admin/programs'
  end

  get '/contact-us' do
    erb :contact_us_form
  end

  post '/contact-us' do
    Database::Contact.insert(params[:user])
    Pony.mail :to => params[:user][:email],
              :from => 'me@example.com',
              :subject => 'Thanks for contacting us!',
              :body => erb(:email, locals: {user: params[:user]})
    Pony.mail :to => "navyosu@gmail.com",
              :from => params[:user][:email],
              :subject => "Issue Reported from #{params[:user][:name]}",
              :body => params[:user][:issue]
    redirect '/thank-you'
  end

  get '/thank-you'
    erb :thank_you
  end

end
