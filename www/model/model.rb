require 'dm-core'
require 'klass.rb'
require 'atribute.rb'

DataMapper::Logger.new($stdout, :debug)

DataMapper.setup(:default, 'postgres://magnifide-www:Mag12@localhost/magnifide-db')
