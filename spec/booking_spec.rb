require_relative '../app/models/booking.rb'

describe Booking do
  subject(:booking) { described_class.new }
  describe "properties" do
    it { is_expected.to have_property :id }
    it { is_expected.to have_property :start_date }
    it { is_expected.to have_property :end_date }
    it { is_expected.to have_property :status }
    it { is_expected.to have_property :total_cost }
  end

end
