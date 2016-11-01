ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative './models/datamapper_setup'

class Makersbnb < Sinatra::Base

  get '/' do
    redirect '/spaces'
  end

  get '/spaces' do
    @spaces = Space.all
    erb :'spaces/spaces'
  end

  get '/spaces/new' do
    erb :new_space
  end

  post '/spaces' do
    @space = Space.create(name: params[:name],
                          address: params[:address],
                          description: params[:description],
                          price: params[:price])
    redirect '/spaces'
  end

  get '/spaces/:id' do
    space = Space.all(id: params[:id])
    @spaces = space
    erb :'spaces/individual'
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
