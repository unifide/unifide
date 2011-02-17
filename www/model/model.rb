require 'rubygems'
require 'bcrypt'
require 'active_record'
require 'yaml'
require 'logger'

dbconfig = YAML::load(File.open('database.yaml'))
ActiveRecord::Base.establish_connection(dbconfig)
ActiveRecord::Base.logger = Logger.new(STDERR)

require 'user'
require 'uclass'
require 'uattribute'
require 'visibility'

require 'unit'
require 'association'
require 'unit_property'
require 'property_value'

require 'association_type'
require 'unit_type'
require 'property_type'
