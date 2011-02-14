#!/usr/bin/env ruby

if ARGV[0] == "help"
	puts "\n\tmake_migration.rb migration-name\n\n\tThis script generates an empty migration where the filename is the current UTC date time prepended to the first argument.\n\tThe migration name should use underscores for spaces.\n\n"
else
	filename = "#{Time.now.utc.strftime "%Y%m%d%H%M%S"}_#{ARGV[0]}.rb"
	cname = ARGV[0].gsub(/(_|^)[a-z]/) {|a| a.upcase}.gsub(/_/,'')
	f = File.open(filename, 'w')
	f.write "class #{cname} < ActiveRecord::Migration\n"
	f.write "\n\tdef self.up\n"
	f.write "\tend\n"
	f.write "\n\tdef self.down\n"
	f.write "\tend\n"
	f.write "end"
end
