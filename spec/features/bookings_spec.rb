feature 'View requests' do
  scenario 'A host can view requests they\'ve received' do
    new_user_1
    new_space_user_id_1
    logout
    new_user_2
    new_booking_user_id_2
    visit '/bookings'
    expect(page).to have_content("My bookings")
    expect(page).to have_content("Two")
  end

  scenario 'A host can see who the request is made by' do
    host_client_booking_setup
    login_user_1
    visit '/bookings'
    expect(page).to have_content("approval for Mary")
  end

  scenario 'host can confirm or reject booking request' do
    
  end
end
