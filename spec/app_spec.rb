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
  end

  describe 'post /spaces' do
    it 'posts a new space' do
      post '/spaces', user_id: 1, name: "One", address: "14 Two Lane", description: "It's a house", price: 130.64
      # post '/spaces', name: "One", address: "14 Two Lane", description: "It's a house", price: 130.64
      expect(last_response.redirect?).to be true
      follow_redirect!
      expect(last_request.path).to eq("/spaces")
    end
  end

end
