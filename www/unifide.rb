$LOAD_PATH << './model'
require 'rubygems'
require 'sinatra'
require 'model'
require 'json'

class Unifide < Sinatra::Base
    get '/' do
        erb :index
    end

    get '/json/:type/:name/:depth' do |type,name,depth|
        #response.headers['Content-type'] = 'application/json'
        response.headers['Content-type'] = 'text/plain'
        JSONReply.reply(type,name,depth)
    end

    get '/units' do
        erb :units
    end

#    get '/:utype/:name' do |t,n|
#	utype = UnitType.where(:name => t).first
#	if utype.nil?
#	    erb :units
#	else
#	    nametype = UnitType.where(:name => "Name").first
#	    hasname = AssociationType.where(:name => "Has Name").first
#	    name = Unit.where(:unit_type => nametype, :value => n).first
#	    assoc = Association.where(:association_type => hasname, :to => name).first
#	    @unit = assoc.from
#	    if @unit.nil?
#		erb :units
#	    else
#		erb :unit
#	    end
#	end
#    end

end
