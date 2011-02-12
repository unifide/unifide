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
			@mtypes = MClass.all
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
				@mtypes = MClass.all
				erb :mclass
			else
				redirect '/'
			end
		end
	end

	post '/attribute' do
		if params[:name].nil? or params[:type].nil? or params[:visibility].nil? or params[:class].nil? or params[:type].nil?
			redirect '/'
		else
			@mattribute = MAttribute.create(:name => params[:name], :visibility_id => params[:visibility], :owner_id => params[:class], :mtype_id => params[:type])
			if @mattribute
				redirect "/class/#{@mattribute.owner.name}"
				#@mtypes = MClass.all
				#@mclass = @mattribute.owner
				#erb :mclass
			else
				redirect '/'
			end
		end
	end
end
