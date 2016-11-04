feature 'View requests' do
  scenario 'A host can view requests they\'ve received' do
    new_user_1
    new_space_user_id_1
    logout
    new_user_2
    new_booking_user_id_2
    visit '/bookings'
    expect(page).to have_content('My bookings')
    expect(page).to have_content('Two')
  end

  scenario 'A host can see who the request is made by and confirm or reject' do
    host_client_booking_setup
    login_user_1
    visit '/bookings'
    expect(page).to have_content('for Mary')
    expect(page).to have_selector(:link_or_button, 'Confirm' && 'Reject')
  end

  scenario 'host can confirm or reject booking request' do
    host_client_booking_setup
    login_user_1
    visit '/bookings'
    click_button 'Confirm'
    expect(page).to have_content('Approved')
  end
end
