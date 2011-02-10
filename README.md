#magnifide

## Development Environment Setup

## Ruby

Once you've got ruby installed run
	gem install bundler

Then run
	cd www
	bundle install


It installs the gem files listed in Gemfile.

### Server

### Database

I've been using PostgreSQL 9. To install on ubuntu follow the instructions [here](http://www.dctrwatson.com/2010/09/installing-postgresql-9-0-on-ubuntu-10-04/).

There needs to be a database called magnified-db running on the local host and a user called magnifide-www with password Mag12.

You'll need the migrations gem if you don't already have it.
	gem install dm-migrations

Once that's setup run
	cd www/model
	ruby -I. migrate.rb

-I. only needed if using ruby 1.9.2.

This will create the tables in the database.
