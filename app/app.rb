ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative './models/datamapper_setup'
require 'bcrypt'

class Makersbnb < Sinatra::Base
  include BCrypt
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
       @invalid_login = params[:invalid_login]
       @logout = params[:logout]
       erb :index
    end
  end

  get '/users/sign_up' do
    @failed = params[:failed]
    erb :'users/new_user'
  end

  post '/users' do
    user = User.create(name: params[:name],
                       email: params[:email],
                       password: params[:password],
                       phone_number: params[:phone_number])
    if user.id.nil?
      redirect to '/users/sign_up?failed=true'
    else
      session[:user_id] = user.id
      redirect to '/spaces'
    end
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
                          user_id: current_user.id)
    redirect to '/spaces'
  end

  get '/bookings' do
    @bookings_requested = current_user.bookings
    @owned_spaces = current_user.spaces
    erb :bookings
  end

  get '/spaces/:id' do
    @space = Space.get(params[:id])
    @space_id = params[:id]
    erb :'spaces/individual'
  end


  post '/bookings/:space_id' do
    @booking = Booking.create(start_date: params[:start_date],
                              end_date: params[:end_date],
                              status: "unconfirmed",
                              user_id: current_user.id,
                              space_id: params[:space_id])
    redirect to '/bookings'
  end

  post '/sessions' do
    user = User.first(email: params[:email])
    if Password.new(user.encrypted_password) == params[:password]
      session[:user_id] = user.id
      redirect to '/spaces'
    else
      redirect to '/?invalid_login=true'
    end

  end

  post '/sessions/logout' do
    session[:user_id] = nil
    redirect to '/?logout=true'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
