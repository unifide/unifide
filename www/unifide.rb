$LOAD_PATH << './model'
require 'rubygems'
require 'sinatra'
require 'model'
require 'json'

class Unifide < Sinatra::Base

    enable :sessions

    helpers do
	attr_reader :current_user
	def user(id) 
	    begin
		User.find(id)
	    rescue ActiveRecord::RecordNotFound
		nil
	    end
	end
	def link_to_unit(unit, text)
	    "<a href=\"/projects/#{unit.project.name}/units/#{unit.unit_type.name}/#{unit.value}\">#{text}</a>"
	end
    end

    before do
	if request.path_info != '/login' and request.path_info != '/register'
	    if session[:user_id].nil? == false
		@current_user = user session[:user_id]
	    end
	end
    end

    before '/projects/:project/?*' do |project|
	@project = Project.where(:name => project).first
	if @project.nil?
	    request.path_info = '/projects'
	else
	    if !@project.public?
		# Project is not public and user is not logged in
		request.path_info = '/welcome' if @current_user.nil?
		# Project is not public and logged in user is not a member
		request.path_info = '/projects' if UserProject.where(:user => @current_user, :project => @project).size == 0
	    end
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
	@user = user id
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
	if !u.nil? and u.password == params[:password]
	    session[:user_id] = u.id
	    redirect '/', 303
	else
	    redirect '/login', 303
	end
    end

    get '/logout' do
	session[:user_id] = nil
	redirect '/welcome'
    end

    get '/projects/?' do
	@projects = Project.where(:public => true)
	if !@current_user.nil?
	    @projects = @projects & @current_user.user_projects.collect {|pu| pu.project}
	end
	erb :projects
    end

    get '/projects/:project/?' do
	erb :project
    end

    get '/projects/:project/units/?' do |project|
	@units = Unit.where(:project => Project.where(:name => project).first).first
	erb :units
    end

    get '/projects/:project/units/:unittype/:name' do |project, unittype, name|
	type = UnitType.where(:name => unittype).first
	@unit = Unit.where(:project_id => @project.id, :unit_type_id => type.id, :value => name).first unless type.nil?
	if @unit.nil?
	    redirect "/#{project}"
	else
	    erb :unit
	end
    end

    not_found do
	'These aren\'t the internets you\'re looking for, <a href="/">move along</a>.'
    end

end
