class ClyffordStillsApp < Sinatra::Base

  set :public, 'public'

  get '/' do
    erb :index
  end

end
