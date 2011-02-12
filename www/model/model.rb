require 'dm-core'
require 'dm-validations'
require 'uclass.rb'
require 'uattribute.rb'
require 'visibility.rb'

DataMapper::Logger.new($stdout, :debug)

DataMapper.setup(:default, 'postgres://unifide-www:Mag12@localhost/unifide-db')
