require 'dm-validations'

class Space
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :description, Text
  property :price, Float
  property :address, Text

  # has n, :bookings, :through => Resource
  # belongs_to, :user
end
