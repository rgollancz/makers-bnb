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
    erb :'spaces/new_space'
  end

  post '/spaces' do
    @space = Space.create(name: params[:name],
                          address: params[:address],
                          description: params[:description],
                          price: params[:price],
                          user_id: 1)
    redirect '/spaces' # once it exists redirect to specific space page
  end

  get '/bookings' do
    erb :bookings
  end

  post '/bookings' do
    @booking = Booking.create(start_date: params[:start_date],
                              end_date: params[:end_date],
                              status: "unconfirmed",
                              total_cost: 0,
                              user_id: 1,
                              space_id: 1)
    redirect '/bookings'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
