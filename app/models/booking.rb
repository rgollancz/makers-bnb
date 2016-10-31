class Booking

  include DataMapper::Resource

  property :id, Serial
  property :start_date, DateTime
  property :end_date, DateTime
  property :status, String
  property :total_cost, Integer

end
