class Booking

  include DataMapper::Resource

  property :id, Serial
  property :start_date, Date
  property :end_date, Date
  property :status, String
  property :total_cost, Decimal

end
