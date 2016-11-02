def new_user
  fill_in :name, with: 'John'
  fill_in :email, with: 'john@email.com'
  fill_in :phone_number, with: '07293728298'
  fill_in :password, with: '123456'
end

def new_space
  visit '/spaces/new'
  fill_in :name, with: 'Treehouse'
  fill_in :address, with: 'In the Tree'
  fill_in :description, with: 'A house in the tree'
  fill_in :price, with: 10.00
  click_on "Save"
end
