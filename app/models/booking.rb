class Booking

  include DataMapper::Resource

  property :id,         Serial
  property :start_date, Date
  property :end_date,   Date
  property :status,     String
  property :total_cost, Decimal, :scale => 2

  belongs_to :user
  belongs_to :space



end
