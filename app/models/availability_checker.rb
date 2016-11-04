class AvailabilityChecker
  def initialize(confirmed_bookings, requested_booking)
    @confirmed_bookings = confirmed_bookings
    @requested_booking = requested_booking
  end

  def available?
    availability = get_confirmed_booking_dates.map do |booking|
      individual_booking_available?(booking)
    end
    !availability.include?(false)
  end

  private
  attr_reader :requested_booking

  def get_confirmed_booking_dates
    @confirmed_bookings.map do |booking|
      { start_date: booking.start_date,
        end_date: booking.end_date }
    end
  end

  def individual_booking_available?(confirmed_booking)
    if requested_booking.start_date <= confirmed_booking[:start_date] && requested_booking.end_date >= confirmed_booking[:end_date]
      return false
    elsif
      requested_booking.start_date >= confirmed_booking[:start_date] && requested_booking.start_date <= confirmed_booking[:end_date]
      return false
    elsif
      requested_booking.end_date >= confirmed_booking[:start_date] && requested_booking.end_date <= confirmed_booking[:end_date]
      return false
    end
    true
  end
end
