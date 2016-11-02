feature 'Sign up as a new user' do
  scenario 'User is directed to sign up page' do
    visit '/'
    expect(page).to have_selector(:link_or_button, 'Sign up')
  end

  scenario 'User can sign up' do
    visit '/'
    new_user
    click_button 'Create account'
    expect(page).to have_content('Logged in as John')
  end
end
