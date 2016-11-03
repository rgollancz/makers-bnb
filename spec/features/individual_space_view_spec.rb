
feature 'Individual space view' do
  scenario 'show details of an individual space' do
    new_user_1
    new_space
    click_button("View space")
    expect(page).to have_content("A house in the tree")
  end

  scenario 'logged out user can\'t request booking or view dates' do
    browser = Capybara.current_session.driver.browser
    new_user_1
    new_space
    browser.clear_cookies
    visit 'spaces/1'
    expect(page).not_to have_content("Check-in date")
  end
end
