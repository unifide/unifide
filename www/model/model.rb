require 'rubygems'
require 'bcrypt'
require 'active_record'
require 'yaml'
require 'logger'

require 'user'
require 'uclass'
require 'uattribute'
require 'visibility'

dbconfig = YAML::load(File.open('database.yaml'))
ActiveRecord::Base.establish_connection(dbconfig)
ActiveRecord::Base.logger = Logger.new(STDERR)
