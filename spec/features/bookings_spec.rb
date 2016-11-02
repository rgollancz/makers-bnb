feature 'View requests' do
  scenario 'A user can view requests they\'ve made' do
    host = User.create(name: "John Smith", email: "j@e.com", phone_number: "00345693485", bio: "I'm a great host")
    client = User.create(name: "Lauren Jones", email: "l@e.com", phone_number: "00345693485", bio: "I'm a great guest")
    space = Space.create(name: "One", address: "14 Two Lane", description: "It's a house", price: 130, user_id: 1)
    booking = Booking.create(start_date: "2016-11-02", end_date: "2016-11-04", status: "unconfirmed", user_id: 2, space_id: 1)
    visit '/bookings'
    expect(page).to have_content("My bookings")
    expect(page).to have_content("One")
  end
end
