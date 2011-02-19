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
	@units = Unit.all
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

    get '/search' do
	@units = Unit.where(:value => params[:name])
	if(@units.size == 0)
	    @value = params[:name]
	    erb :_unit_form
	else
	    erb :units
	end
    end

    get '/*' do
	'These aren\'t the internets you\'re looking for, <a href="/">move along</a>.'
    end

end
