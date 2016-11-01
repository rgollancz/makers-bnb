ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative './models/datamapper_setup'

class Makersbnb < Sinatra::Base

  get '/' do
    'Hello Makersbnb!'
  end

  get '/spaces/new' do
    erb :new_space
  end

  post '/spaces' do
    @space = Space.create(name: params[:name],
                          address: params[:address],
                          description: params[:description],
                          price: params[:price])
    redirect '/spaces' # once it exists redirect to specific space page
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
