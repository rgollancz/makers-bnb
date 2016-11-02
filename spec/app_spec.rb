require 'rack/test'

describe Makersbnb do
  include Rack::Test::Methods

  def app
    Makersbnb
  end
  describe 'get /' do
    it 'displays the home page' do
      get '/'
      expect(last_response).to be_ok
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
      Space.create(name: "One", address: "14 Two Lane", description: "It's a house", price: 130, user_id: 1)
      get '/spaces/1'
      expect(last_response).to be_ok
      expect(last_response.body).to include "Check-in date"
    end
  end

  describe 'post /spaces' do
    it 'posts a new space' do
      post '/spaces', user_id: 1, name: "One", address: "14 Two Lane", description: "It's a house", price: 130
      expect(last_response.redirect?).to be true
      follow_redirect!
      expect(last_request.path).to eq("/spaces")
    end
  end

  describe 'post /bookings' do
    it 'redirects to /bookings' do
      post '/bookings/2', start_date: "2016-11-02", end_date: "2016-11-03", user_id: 1, space_id: 2
      expect(last_response.redirect?).to be true
      follow_redirect!
      expect(last_request.path).to eq("/bookings")
    end
  end

end
