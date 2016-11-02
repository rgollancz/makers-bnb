require 'dm-validations'

class Space
  include DataMapper::Resource

  property :id,           Serial
  property :name,         String
  property :address,      Text
  property :description,  Text
  property :price,        Integer

  has n, :bookings
  belongs_to :user
end
