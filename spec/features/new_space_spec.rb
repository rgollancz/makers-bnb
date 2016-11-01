feature 'Add a new space' do
  scenario 'A host can view the page to add a new space' do
    visit '/spaces/new'
    expect(page).to have_content("Add a new listing")
    expect(page).to have_selector(:link_or_button, 'Save')
  end


end
