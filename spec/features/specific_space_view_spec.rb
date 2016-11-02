
describe Space do
  scenario 'prints an individual space' do
    new_space
    visit '/spaces'
    click_button("View Space")
    expect(page).to have_content("A house")

  end

end
