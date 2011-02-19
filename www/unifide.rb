$LOAD_PATH << './model'
require 'rubygems'
require 'sinatra'
require 'model'
require 'json'

class Unifide < Sinatra::Base

    enable :sessions

    helpers do
	attr_reader :current_user
	def user(id) User.find(id) end
    end

    before do
	if session[:user_id].nil? == false
	    @current_user = user session[:user_id]
	end
	if @current_user.nil?
	    request.path_info = '/welcome' unless request.path_info == '/login'
	end
    end

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

    get '/register' do
	erb :_registration_form
    end

    post '/register' do
	params[:join_date] = DateTime.now
	@user = User.new(params)
	if @user.save.nil?
	    erb :register
	else
	    session[:user_id] = @user.id
	    @current_user = @user
	    redirect "/user/#{@user.id}"
	end
    end

    get '/user/:id' do |id|
	@user = User.find(id)
	if @user.nil?
	    redirect '/register'
	else
	    erb :user
	end
    end

    get '/welcome' do
	#Logged in users have no need of a welcome page
	if @current_user.nil?
	    erb :welcome
	else
	    redirect '/'
	end
    end

    get '/login' do
	erb :_login_form
    end

    post '/login' do
	u = User.where(:email => params[:email]).first
	if u.password == params[:password]
	    session[:user_id] = u.id
	    redirect '/', 303
	else
	    redirect '/login', 303
	end
    end

    not_found do
	'These aren\'t the internets you\'re looking for, <a href="/">move along</a>.'
    end

end
