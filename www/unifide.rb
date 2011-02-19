$LOAD_PATH << './model'
require 'rubygems'
require 'sinatra'
require 'model'
require 'json'

class Unifide < Sinatra::Base
    get '/' do
        erb :index
    end

    post '/json/:type/:name/:depth' do |type,name,depth|
        response.headers['Content-type'] = 'application/json'
        JSONReply.reply(type,name,depth)
    end

    get '/units' do
        erb :units
    end

    get '/unit/:id' do |id|
	@unit = Unit.find(id)
	if @unit.nil?
	    erb :units
	else
	    erb :unit
	end
    end

end
