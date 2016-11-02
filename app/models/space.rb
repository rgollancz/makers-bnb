require 'dm-validations'

class Space
  include DataMapper::Resource

  property :id,           Serial
  property :name,         String
  property :address,      Text
  property :description,  Text
  property :price,        Integer

  has n, :bookings, :through => Resource
  belongs_to :user
end
