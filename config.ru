ENV['RACK_ENV'] = 'development'

require 'rubygems'
require File.join(File.dirname(__FILE__), 'app/app.rb')

run Makersbnb

require 'dm-core'
require 'dm-migrations'
