require 'rack/test'

describe Makersbnb do
  include Rack::Test::Methods

  def app
    Makersbnb
  end

  def post_new_user
    post '/users', name: "John",
                   email: "John@email.com",
                   password: "password1234",
                   phone_number: "123456",
                   id: 1
  end

  describe 'get /' do
    it 'displays the home page with log in form' do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to include "Log in to Makers BnB"
    end
    it 'redirects to bookings if user is signed in' do
      post_new_user
      get '/'
      expect(last_response.redirect?).to be true
      follow_redirect!
      expect(last_request.path).to eq("/spaces")
    end
  end

  describe 'get /users/sign_up' do
    it 'displays sign up form' do
      get '/users/sign_up'
      expect(last_response).to be_ok
      expect(last_response.body).to include "Name"
      expect(last_response.body).to include "Password"
      expect(last_response.body).to include "Email"
    end
  end

  describe 'post /users' do
    it 'creates new user' do
      post_new_user
      user = User.first(email: "John@email.com")
      expect(user.name).to eq "John"
      expect(user.phone_number).to eq "123456"
    end

    it 'sets the user id in the session' do
      post_new_user
      user = User.first(email: "John@email.com")
      expect(last_request.session[:user_id]).to eq user.id
    end

    it 'displays an error message when signup fails' do
      browser = Capybara.current_session.driver.browser
      new_user_1
      browser.clear_cookies
      visit '/'
      new_user_1
      expect(page).to have_content("Signup failed - please try again")
    end

    it 'redirects to /spaces' do
      post_new_user
      expect(last_response.redirect?).to be true
      follow_redirect!
      expect(last_request.path).to eq("/spaces")
    end
  end

  describe 'get /spaces' do
    it 'displays the spaces page' do
      get '/spaces'
      expect(last_response).to be_ok
      expect(last_response.body).to include "Spaces"
    end
    it 'displays the add new space page' do
      get '/spaces/new'
      expect(last_response).to be_ok
    end
    it 'displays the individual space page' do
      post_new_user
      Space.create(name: "One",
                   address: "14 Two Lane",
                   description: "It's a house",
                   price: 130,
                   id: 1,
                   user_id: 1)
      get '/spaces/1'
      expect(last_response).to be_ok
      expect(last_response.body).to include "Check-in date"
    end
  end

  describe 'post /spaces' do
    it 'posts a new space' do
      post_new_user
      post '/spaces', name: "One",
                      address: "14 Two Lane",
                      description: "It's a house",
                      price: 130
      expect(last_response.redirect?).to be true
      follow_redirect!
      expect(last_request.path).to eq("/spaces")
    end

    it 'displays an error message when saving fails' do
      new_user_1
      new_space_error
      expect(page).to have_content("Saving new space failed - please try again")
    end
  end

  describe 'get /bookings' do
    it 'displays the bookings page if user is logged in' do
      post_new_user
      get '/bookings'
      expect(last_response).to be_ok
    end
  end

  # describe 'post /bookings' do
  #   it 'redirects to /bookings when booking is available' do
  #     post_new_user
  #     get '/bookings'
  #     expect(last_response.redirect?).to be true
  #     follow_redirect!
  #     expect(last_request.path).to eq("/bookings")
  #   end
  # end

  describe 'post /sessions' do
    it 'sets the user id in the session for a valid login' do
      post_new_user
      post "/sessions/logout"
      post '/sessions', email: "John@email.com", password: "password1234"
      expect(last_request.session[:user_id]).to eq 1
    end
    it 'redirects back to login page for invalid password' do
      post_new_user
      post "/sessions/logout"
      post '/sessions', email: "John@email.com", password: "wrongpassword"
      expect(last_request.session[:user_id]).to eq nil
      expect(last_response.redirect?).to be true
      follow_redirect!
      expect(last_request.path).to eq("/")
    end
  end

  describe 'post sessions/logout' do
    it "logs out current user" do
      post_new_user
      post "/sessions/logout"
      expect(last_request.session[:user_id]).to eq(nil)
    end
    it "redirects to home page" do
      post "/sessions/logout"
      expect(last_response.redirect?).to be true
      follow_redirect!
      expect(last_request.path).to eq("/")
    end
  end


end
