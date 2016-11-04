class AvailabilityChecker
  def initialize(approved_bookings, requested_booking)
    @approved_bookings = approved_bookings
    @requested_booking = requested_booking
  end

  def available?
    availability = get_approved_booking_dates.map do |booking|
      individual_booking_available?(booking)
    end
    !availability.include?(false)
  end

  private
  attr_reader :requested_booking

  def get_approved_booking_dates
    @approved_bookings.map do |booking|
      { start_date: booking.start_date,
        end_date: booking.end_date }
    end
  end

  def individual_booking_available?(approved_booking)
    if requested_booking.start_date <= approved_booking[:start_date] && requested_booking.end_date >= approved_booking[:end_date]
      return false
    elsif
      requested_booking.start_date >= approved_booking[:start_date] && requested_booking.start_date <= approved_booking[:end_date]
      return false
    elsif
      requested_booking.end_date >= approved_booking[:start_date] && requested_booking.end_date <= approved_booking[:end_date]
      return false
    end
    true
  end
end
