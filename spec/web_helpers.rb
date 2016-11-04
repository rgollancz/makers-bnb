def new_user_1
  visit '/users/sign_up'
  fill_in :name, with: 'John'
  fill_in :email, with: 'john@email.com'
  fill_in :password, with: '123456'
  fill_in :phone_number, with: '07293728298'
  click_button 'Sign up'
end

def new_user_2
  visit '/users/sign_up'
  fill_in :name, with: 'Mary'
  fill_in :email, with: 'mary@email.com'
  fill_in :password, with: '123456'
  fill_in :phone_number, with: '07293728298'
  click_button 'Sign up'
end

def login_user_1
  visit '/'
  fill_in :email, with: 'john@email.com'
  fill_in :password, with: '123456'
  click_button 'Login'
end


def logout
  visit '/'
  click_button 'Logout'
end

def host_client_booking_setup
  new_user_1
  new_space_user_id_1
  logout
  new_user_2
  new_booking_user_id_2
  logout
end

def new_space
  visit '/spaces/new'
  fill_in :name, with: 'Treehouse'
  fill_in :address, with: 'In the Tree'
  fill_in :description, with: 'A house in the tree'
  fill_in :price, with: 10.00
  click_on "Save"
end

def new_space_user_id_1
  Space.create(name: "Two", address: "14 Two Lane", description: "It's a house", price: 130, user_id: 1)
end

def new_booking_user_id_2
  Booking.create(start_date: "2016-11-02", end_date: "2016-11-04", status: "unconfirmed", user_id: 2, space_id: 1)
end

def new_space_error
  visit '/spaces/new'
  fill_in :name, with: 'Treehouse'
  fill_in :address, with: 'In the Tree'
  fill_in :description, with: 'A house in the tree'
  click_on "Save"
end

def book_space
  visit '/spaces/1'
  fill_in :start_date, with: '2016-11-02'
  fill_in :end_date, with: '2016-11-04'
  click_button "Request to book"
end

def book_space_error
  fill_in :start_date, with: '12122016'
  click_button "Request to book"
end
