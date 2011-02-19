require 'rubygems'
require 'bcrypt'
require 'active_record'
require 'yaml'
require 'logger'

dbconfig = YAML::load(File.open('database.yaml'))
ActiveRecord::Base.establish_connection(dbconfig)
ActiveRecord::Base.logger = Logger.new(STDERR)

require 'user'

require 'unit'
require 'unit_type'
require 'association'
require 'association_type'
