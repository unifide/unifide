$LOAD_PATH << './model'
require 'rubygems'
require 'sinatra'
require 'model'
require 'json'

class Unifide < Sinatra::Base
    get '/' do
        erb :index
    end

    post '/:type/:name/json' do |type,name|
        response.headers['Content-type'] = 'application/json'
        JSONReply.reply(type,name)
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

    post '/unit' do
	@unit = Unit.create(params)
	redirect '/units'
    end

    post '/association' do
	association = Association.create(params)
	redirect "/unit/#{association.from.id}"
    end

end
