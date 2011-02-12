require 'dm-core'
require 'dm-validations'
require 'mclass.rb'
require 'mattribute.rb'
require 'visibility.rb'

DataMapper::Logger.new($stdout, :debug)

DataMapper.setup(:default, 'postgres://magnifide-www:Mag12@localhost/magnifide-db')
