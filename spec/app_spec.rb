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
      post '/spaces'
      expect(last_response).to be_ok
    end
  end

end
