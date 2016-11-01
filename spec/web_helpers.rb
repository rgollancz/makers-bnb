def new_user
  fill_in :created_at, with '2016-10-31 17:57:59'
  fill_in :name, with 'John'
  fill_in :email, with 'john@email.com'
  fill_in :phone_number, with '07293728298'
  fill_in :bio, with 'Lovely man'
end
