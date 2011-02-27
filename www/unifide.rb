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
	def get_project(shortname)
	    Project.where(:short_name => shortname).first
	end
	def user_can_see_project?(user, project)
	    (project.public? or (!user.nil? and project.project_users.select {|pu| pu.user_id == user.id}.empty?))
	end
	def get_unit(project, type, name)
	    Unit.where(:project_id => project.id, :unit_type_id => UnitType.where(:name => type).first, :value => name).first
	end
    end

    before do
	if session[:user_id].nil? == false
	    current_user = user session[:user_id]
	end
    end

    get '/' do
        erb :index
    end

    get '/:type/:name/json' do |type,name|
        response.headers['Content-type'] = 'application/json'
        JSONReply.reply(type,name)
    end

    get '/currentuser/?' do
	json ||= {}
	if current_user.nil?
	    json[:guest] = true
	else
	    json[:guest] = false
	    json[:username] = current_user.username
	end
	response['Content-type'] = "application/json"
	json.to_json
    end

    put '/currentuser/?' do
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

    delete '/currentuser/?' do
	session[:user_id] = nil
	response['Content-type'] = "application/json"
	{:success => true}.to_json
    end

    get '/users/?' do
	json ||= {}
	json[:users] = User.all.collect {|user| {:username => user.username}}
	response['Content-type'] = "application/json"
	json.to_json
    end

    put '/users/:username/?' do |username|
	json ||= {:success => false}
	params[:join_date] = DateTime.now
	params[:username] = username
	user = User.new(params)
	if !user.save.nil?
	    session[:user_id] = user.id
	    json[:success] = true
	end
	response['Content-type'] = "application/json"
	json.to_json
    end

    post '/users/:username/?' do |username|
	response['Content-type'] = "application/json"
	{:success => false}.to_json
    end

    get '/users/:username/?' do |username|
	json ||= {:success => false}
	user = User.where(:username => username).first
	if !user.nil?
	    json[:success] = true
	    userjson = {:username => user.username}
	    if !current_user.nil?
		userjson[:name] = user.name
		if current_user == user
		    userjson[:first_name] = user.first_name
		    userjson[:second_name] = user.second_name
		    userjson[:email] = user.email
		end
	    end
	    json[:user] = userjson
	end
	response['Content-type'] = "application/json"
	json.to_json
    end
    
    delete '/users/:username/?' do |username|
	response['Content-type'] = "application/json"
	{:success => false}.to_json
    end

    get '/projects/?' do
	projects = Project.where(:public => true)
	json ||= {}
	if !current_user.nil?
	    json[:user] = current_user.user_projects.collect {|pu| {:short_name => pu.project.short_name, :name => pu.project.name, :public => pu.project.public, :admin => pu.admin}}
	    projects = projects - current_user.user_projects.collect {|pu| pu.project}
	end
	json[:public] = projects.collect {|p| {:short_name => p.short_name, :name => p.name, :public => p.public}}
	json[:success] = true
	response['Content-type'] = "application/json"
	json.to_json
    end

    get '/projects/:name/?' do |name|
	json ||= {}
	project = get_project name
	if user_can_see_project? current_user, project
	    json[:success] = true
	    json[:project] = {:short_name => project.short_name, :name => project.name, :public => project.public, :users => project.project_users.collect {|pu| {:username => pu.user.username, :admin => pu.admin }}}
	end
	response['Content-type'] = "application/json"
	json.to_json
    end

    get '/units/:project/?' do |project_name|
	json ||= {:success => false}
	project = get_project project_name
	if user_can_see_project? current_user, project
	    json[:units] = project.units.collect {|unit| unit.to_json}
	    json[:success] = true
	end
	response['Content-type'] = "application/json"
	json.to_json
    end

    get '/units/:project/:typename/?' do |project_name, typename|
	json ||= {:success => false}
	project = get_project project_name
	if user_can_see_project? current_user, project
	    type = UnitType.where(:name => typename).first
	    if !type.nil?
		json[:success] = true
		json[:units] = type.units.collect {|unit| unit.to_json}
	    end
	end
	response['Content-type'] = "application/json"
	json.to_json
    end

    get '/units/:project/:typename/:name/?' do |project_name, typename, name|
	json ||= {:success => false}
	project = get_project project_name
	if user_can_see_project? current_user, project
	    unit = get_unit project, typename, name
	    if !unit.nil?
		params[:depth] ||= 1
		depth = params[:depth].to_i
		json[:success] = true
		json[:depth] = depth
		units = unit.get_neighbours(depth)
		projects = Project.where(:id => units.collect{|u| u.project_id}).collect {|p| p.short_name}
		json[:units] = {}
		assocs = Association.get_relationships(units)
		projects.each do |p|
		    json[:units][p] = {}
		    UnitType.where(:id => units.collect {|u| u.unit_type_id}).each do |ut|
			json[:units][p][ut.name] = []
			units.select {|u| u.project.short_name == p and u.unit_type_id == ut.id}.each do |u|
			    as = {}
			    AssociationType.where(:id => assocs.select {|a| a.from_id == u.id }.collect {|a| a.association_type_id}).each do |at|
				as[at.name] = u.from_associations.select {|a| a.association_type_id == at.id and units.include? a.to}.collect{|a| units.index(a.to)}
			    end
			    json[:units][p][ut.name] << [units.index(u), u.value, as]
			end
		    end
		end
	    end
	end
	response['Content-type'] = "application/json"
	json.to_json
    end

    not_found do
	'These aren\'t the internets you\'re looking for, <a href="/">move along</a>.'
    end

end
