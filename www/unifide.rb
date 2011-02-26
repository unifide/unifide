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
	if session[:user_id].nil? == false
	    @current_user = user session[:user_id]
	end
	if request.path_info != '/login' && request.path_info != '/register' and @current_user.nil? and (request.put? or request.post? or request.delete?)
	    request.path_info = '/no'
	end
    end

    before '/projects/:project/?*' do |project|
	@project = Project.where(:name => project).first
	if !request.put?
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
    end

    get '/' do
        erb :index
    end

    get '/:type/:name/json' do |type,name|
        response.headers['Content-type'] = 'application/json'
        JSONReply.reply(type,name)
    end

    post '/register' do
	json ||= {:success => false}
	params[:join_date] = DateTime.now
	@user = User.new(params)
	if !@user.save.nil?
	    session[:user_id] = @user.id
	    
	    json[:success] = true
	    json[:name] = @user.name
	    json[:email] = @user.email
	end
	response['Content-type'] = "application/json"
	json.to_json
    end

    post '/login' do
	u = User.where(:username => params[:username]).first
	json ||= {}
	json[:success] = false
	if !u.nil? and u.password == params[:password]
	    session[:user_id] = u.id
	    
	    json[:success] = true
	    json[:name] = u.name
	    json[:email] = u.email
	    json[:username] = u.username
	end
	response['Content-type'] = "application/json"
	json.to_json
    end

    put '/projects/:project' do |project|
	
    end

    post '/logout' do
	session[:user_id] = nil
	{:success => true}.to_json
    end

    get '/projects/?' do
	@projects = Project.where(:public => true)
	json ||= {}
	if !@current_user.nil?
	    json[:user] = @current_user.user_projects.collect {|pu| {:short_name => pu.project.short_name, :name => pu.project.name, :public => pu.project.public, :admin => pu.admin}}
	    @projects = @projects - @current_user.user_projects.collect {|pu| pu.project}
	end
	json[:public] = @projects.collect {|p| {:short_name => p.short_name, :name => p.name, :public => p.public}}
	json[:success] = true
	response['Content-type'] = "application/json"
	json.to_json
    end

    get '/projects/:project/units/?' do |project|
	response.headers["Content-type"] = "json"
	units = Unit.where(:project_id => Project.where(:name => project).first.id)
	json ||= {}
	json[:units] = units.collect {|unit| {:name => unit.value, :type => unit.unit_type.name, :project => unit.project.name}}
	json[:success] = true
	response['Content-type'] = "application/json"
	json.to_json
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
