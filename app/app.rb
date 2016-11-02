ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative './models/datamapper_setup'

class Makersbnb < Sinatra::Base

  get '/' do
    "Hello Makers BnB"
  end

  get '/users/sign_up' do
    erb :'users/new_user'
  end

  get '/spaces' do
    @spaces = Space.all
    erb :'spaces/spaces'
  end

  get '/spaces/new' do
    erb :'spaces/new_space'
  end

  post '/spaces' do
    @space = Space.create(name: params[:name],
                          address: params[:address],
                          description: params[:description],
                          price: params[:price],
                          user_id: 1)
    redirect to '/spaces'
  end

  get '/spaces/:id' do
    @space = Space.get(params[:id])
    @space_id = params[:id]
    erb :'spaces/individual'
  end

  get '/bookings' do
    erb :bookings
  end

  post '/bookings/:space_id' do
    @booking = Booking.create(start_date: params[:start_date],
                              end_date: params[:end_date],
                              status: "unconfirmed",
                              user_id: 1,
                              space_id: params[:space_id])
    redirect to '/bookings'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
