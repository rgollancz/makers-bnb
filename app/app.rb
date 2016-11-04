ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative './models/datamapper_setup'
require 'bcrypt'
require_relative './models/availability_checker'

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
    @failed = params[:failed]
    erb :'spaces/new_space'
  end

  post '/spaces' do
    @space = Space.create(name: params[:name],
                          address: params[:address],
                          description: params[:description],
                          price: params[:price],
                          user_id: current_user.id)
    if @space.id.nil?
      redirect to '/spaces/new?failed=true'
    else
      redirect to '/spaces'
    end
  end

  get '/bookings' do
    if current_user
      @bookings_requested = current_user.bookings
      spaces = Space.all(user_id: current_user.id)
      @bookings = spaces.all.bookings
      erb :bookings
    else
      redirect to '/'
    end
  end

  get '/spaces/:id' do
    @space = Space.get(params[:id])
    @space_id = params[:id]
    @failed = params[:failed]
    erb :'spaces/individual'
  end


  post '/bookings/:space_id' do
    @booking = Booking.create(start_date: params[:start_date],
                              end_date: params[:end_date],
                              status: "pending",
                              user_id: current_user.id,
                              space_id: params[:space_id])
    space = Space.get(params[:space_id])
    approved_bookings = space.bookings.select { |booking| booking.status == "approved" }
    check_booking = AvailabilityChecker.new(approved_bookings, @booking)
    if check_booking.available?
      redirect to '/bookings'
    else
      redirect to "/spaces/#{params[:space_id]}"
    end
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
