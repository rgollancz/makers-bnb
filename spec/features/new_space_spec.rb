feature 'Add a new space' do
  scenario 'A host can view the page to add a new space' do
    visit '/spaces/new'
    expect(page.status_code).to eq 200
    expect(page).to have_content("Add a new listing")
    expect(page).to have_selector(:link_or_button, 'Save')
  end

  before(:each) do
    @user = User.create(name: params[:name],
    email: params[:email],
    username: params[:username],
    password: params[:password],
  end
  
end
