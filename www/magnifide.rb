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
		@mclass = MClass.first(:name => n)
		if @mclass
			erb :mclass
		else
			erb :index
		end
	end

	post '/class' do
		if params[:name].nil? or params[:visibility].nil?
			redirect '/'
		else
			@mclass = MClass.create(:name => params[:name], :visibility_id => params[:visibility])
			if @mclass
				erb :mclass
			else
				redirect '/'
			end
		end
	end
end
