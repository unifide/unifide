require 'dm-core'
require 'dm-validations'
require 'klass.rb'
require 'atribute.rb'
require 'visibility.rb'

DataMapper::Logger.new($stdout, :debug)

DataMapper.setup(:default, 'postgres://magnifide-www:Mag12@localhost/magnifide-db')
