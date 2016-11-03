def new_user_1
  visit '/users/sign_up'
  fill_in :name, with: 'John'
  fill_in :email, with: 'john@email.com'
  fill_in :password, with: '123456'
  fill_in :phone_number, with: '07293728298'
  click_button 'Sign up'
end

def new_space
  visit '/spaces/new'
  fill_in :name, with: 'Treehouse'
  fill_in :address, with: 'In the Tree'
  fill_in :description, with: 'A house in the tree'
  fill_in :price, with: 10.00
  click_on "Save"
end

def new_space_error
  visit '/spaces/new'
  fill_in :name, with: 'Treehouse'
  fill_in :address, with: 'In the Tree'
  fill_in :description, with: 'A house in the tree'
  click_on "Save"
end


def book_space
  fill_in :start_date, with: '12122016'
  fill_in :end_date, with: '14122016'
  click_button "Request to book"
end

def book_space_error
  fill_in :start_date, with: '12122016'
  click_button "Request to book"
end
