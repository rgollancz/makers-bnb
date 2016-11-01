describe Space do
  scenario 'prints an individual space' do
    new_space
    visit '/spaces/2'
    expect(page).to have_content("Treehouse")
  end

end
