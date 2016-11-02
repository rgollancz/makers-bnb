ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative './models/datamapper_setup'

class Makersbnb < Sinatra::Base

  enable :sessions

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/' do
    if current_user
      redirect '/spaces'
    else
       redirect 'users/sign_up'
    end
  end

  get '/users/sign_up' do
    erb :'users/new_user'
  end

  post '/users' do
    user = User.create(name: params[:name],
                       email: params[:email],
                       password: params[:password],
                       phone_number: params[:phone_number])
    session[:user_id] = user.id
    redirect to '/spaces'
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
    user = User.get(2)
    @bookings_requested = user.bookings
    @owned_spaces = user.spaces
    erb :bookings
  end

  post '/bookings/:space_id' do
    @booking = Booking.create(start_date: params[:start_date],
                              end_date: params[:end_date],
                              status: "unconfirmed",
                              user_id: 1,
                              space_id: params[:space_id])
    redirect to '/spaces/:space_id'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
