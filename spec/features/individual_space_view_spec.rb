
feature 'Individual space view' do
  scenario 'show details of an individual space' do
    new_user_1
    new_space
    click_button("View space")
    expect(page).to have_content("A house in the tree")
  end
end
