feature 'View requests' do
  scenario 'A host can view requests they\'ve received', focus: true do
    new_user_1
    Space.create(name: "Two", address: "14 Two Lane", description: "It's a house", price: 130, user_id: 1)
    logout
    new_user_2
    book_space
    expect(page).to have_content("My bookings")
    expect(page).to have_content("Two")
  end

end
