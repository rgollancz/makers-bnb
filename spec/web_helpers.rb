def new_user
  fill_in :name, with 'John'
  fill_in :email, with 'john@email.com'
  fill_in :phone_number, with '07293728298'
  fill_in :bio, with 'Lovely man'
  fill_in :password, with 'Lovely man'
end
