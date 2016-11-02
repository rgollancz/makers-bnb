require 'dm-validations'
require 'bcrypt'

class User

  include DataMapper::Resource
  include BCrypt

  attr_reader :password

  property :id,                 Serial
  property :created_at,         DateTime
  property :name,               String
  property :email,              String, unique: true
  property :phone_number,       String
  property :bio,                Text
  property :encrypted_password, BCryptHash

  has n, :spaces
  has n, :bookings

  def password=(password)
    @password = password
    self.encrypted_password = BCrypt::Password.create(password)
  end

end
