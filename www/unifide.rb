$LOAD_PATH << './model'
require 'rubygems'
require 'sinatra'
require 'model'

class Unifide < Sinatra::Base
    post '/json' do
        response.headers['Content-type'] = 'application/json'
        # might want to use the /json path for AJAX JSON requests
        '{"a":1,"b":"two"}'
    end

    get '/' do
        erb :index
    end

    get '/class' do
        erb :class
    end

    get '/class/:name' do |n|
        @uclass = UClass.where(:name => n).first
        if @uclass
            @mtypes = UClass.all
            erb :uclass
        else
            erb :index
        end
    end

    post '/class' do
        if params[:name].nil? or params[:visibility].nil?
            redirect '/class'
        else
            @uclass = UClass.create(:name => params[:name], :visibility_id => params[:visibility])
            if @uclass
                @mtypes = UClass.all
                erb :uclass
            else
                redirect '/'
            end
        end
    end

    post '/attribute' do
        if params[:name].nil? or params[:type].nil? or params[:visibility].nil? or params[:class].nil? or params[:type].nil?
            redirect '/'
        else
            @uattribute = UAttribute.create(:name => params[:name], :visibility_id => params[:visibility], :owner_id => params[:class], :type_id => params[:type])
            if @uattribute
                redirect "/class/#{@uattribute.owner.name}"
            else
                redirect '/'
            end
        end
    end
end
