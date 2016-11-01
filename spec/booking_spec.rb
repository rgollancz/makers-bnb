describe Booking do
  subject(:booking) { described_class.new }
  subject(:booking_cost) { described_class.create(start_date: "2016-11-02",
                                                  end_date: "2016-11-04",
                                                  status: "unconfirmed",
                                                  user_id: 1,
                                                  space_id: 1
                                                  )}

  describe "properties" do
    it { is_expected.to have_property :id }
    it { is_expected.to have_property :start_date }
    it { is_expected.to have_property :end_date }
    it { is_expected.to have_property :status }
  end

end
