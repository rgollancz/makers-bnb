require_relative '../app/models/availability_checker'

describe AvailabilityChecker do
  let(:booking_1) { double :booking, start_date: "2016-11-02", end_date: "2016-11-04" }
  let(:booking_2) { double :booking, start_date: "2016-10-08", end_date: "2016-11-10" }
  let(:booking_3) { double :booking, start_date: "2016-11-01", end_date: "2016-11-06" }
  let(:booking_4) { double :booking, start_date: "2016-11-07", end_date: "2016-11-14" }
  let(:booking_5) { double :booking, start_date: "2016-09-07", end_date: "2016-09-14" }
  let(:booking_6) { double :booking, start_date: "2016-11-01", end_date: "2016-11-08" }

  it 'responds to available? with true when there are no confirmed bookings' do
    checker = AvailabilityChecker.new([], booking_5)
    expect(checker.available?).to eq true
  end

  it 'responds to available? with true when dates do not clash' do
    checker = AvailabilityChecker.new([booking_6], booking_5)
    expect(checker.available?).to eq true
  end

  it 'responds to available? with false when the requested booking is within the confirmed booking' do
    checker = AvailabilityChecker.new([booking_6], booking_1)
    expect(checker.available?).to eq false
  end

  it 'responds to available? with false when confirmed is within the requested booking' do
    checker = AvailabilityChecker.new([booking_6], booking_2)
    expect(checker.available?).to eq false
  end

  it 'responds to available? with false when start date for confirmed and requestsed bookings are the same' do
    checker = AvailabilityChecker.new([booking_6], booking_3)
    expect(checker.available?).to eq false
  end

  it 'responds to available? with false when requested booking starts after, and ends after the confirmed booking' do
    checker = AvailabilityChecker.new([booking_6], booking_4)
    expect(checker.available?).to eq false
  end

  it 'responds to available? with false when there is at least one date that clashes' do
    checker = AvailabilityChecker.new([booking_1,booking_2,booking_3,booking_4,booking_5], booking_6)
    expect(checker.available?).to eq false
  end
end
