ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative './models/datamapper_setup'

class Makersbnb < Sinatra::Base

  get '/' do
    'Hello Makersbnb!'
  end

  get '/spaces' do
    @spaces = Space.all
    erb :'spaces/spaces'
  end

  get '/spaces/new' do
  end

 post '/spaces' do
   #  create new space
   # redirect to new space page
 end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
