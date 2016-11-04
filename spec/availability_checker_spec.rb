require_relative '../app/models/availability_checker'

describe AvailabilityChecker do
  let(:booking_1) { double :booking, start_date: "2016-11-02", end_date: "2016-11-04" }
  let(:booking_2) { double :booking, start_date: "2016-11-02", end_date: "2016-11-04" }
  let(:booking_3) { double :booking, start_date: "2016-11-06", end_date: "2016-11-08" }
  subject(:checker_1) { described_class.new([booking_1], booking_2) }
  subject(:checker_2) { described_class.new([booking_2], booking_3) }

  it 'responds to available? with false when dates clash' do
    expect(checker_1.available?).to eq false
  end

  it 'responds to available? with true when dates do not clash' do
    expect(checker_2.available?).to eq true
  end

end
