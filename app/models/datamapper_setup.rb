require 'data_mapper'
require 'dm-postgres-adapter'

require_relative './space'
require_relative './user'
require_relative './booking'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/makers_bnb_#{ENV['RACK_ENV']}")
DataMapper.finalize
DataMapper.auto_upgrade!
# Uncomment below to check whether objects are saving to database
#DataMapper::Model.raise_on_save_failure = true
