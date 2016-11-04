feature 'View requests' do
  scenario 'A host can view requests they\'ve received' do
    new_user_1
    Space.create(name: "Two", address: "14 Two Lane", description: "It's a house", price: 130, user_id: 1)
    logout
    new_user_2
    Booking.create(start_date: "2016-11-02", end_date: "2016-11-04", status: "unconfirmed", user_id: 2, space_id: 1)
    visit '/bookings'
    expect(page).to have_content("My bookings")
    expect(page).to have_content("Two")
  end
end
