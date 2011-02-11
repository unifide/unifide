$LOAD_PATH << './model'
require 'rubygems'
require 'sinatra'
require 'model'

class Magnifide < Sinatra::Base
    post '/json' do
        response.headers['Content-type'] = 'application/json'
        # might want to use the /json path for AJAX JSON requests
        '{"a":1,"b":"two"}'
    end

    get '/' do
        erb :index
    end

	get '/class/:name' do |n|
		@klass = Klass.first(:name => n)
		if @klass
			erb :klass
		else
			erb :index
		end
	end
end

