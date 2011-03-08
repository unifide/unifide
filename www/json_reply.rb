require 'json'
require 'model'

class JSONReply

    def self.write_project(user, project_name, hm)
        project = Project.find_by_short_name project_name
	if !project.nil?
	    #The project exists
            if user_can_write_project? user, project
		#The user can write to the project
		yield project
            else
	        hm[:errors] = [@@error_messages[:write_permission]]
	    end
	else
	    hm[:errors] = [@@error_messages[:no_project]]
	end
    end

    def self.access_project(user, project_name, hm)
        project = Project.find_by_short_name project_name
	if !project.nil?
	    #The project exists
            if user_can_see_project? user, project
		#The user can access the project
		yield project
            else
	        hm[:errors] = [@@error_messages[:permission]]
	    end
	else
	    hm[:errors] = [@@error_messages[:no_project]]
	end
    end

    def self.write_unit_type(user, project_name, type_name, hm)
	self.write_project user, project_name, hm do |project|
	    unit_type = UnitType.find_by_name type_name
	    yield project, unit_type
	end
    end

    def self.access_unit_type(user, project_name, type_name, hm)
	self.access_project user, project_name, hm do |project|
	    unit_type = UnitType.find_by_name type_name
	    if !unit_type.nil?
		yield project, unit_type
	    else
		hm[:errors] = [@@error_messages[:no_unit_type]]
	    end
	end
    end

    def self.write_unit(user, project_name, type_name, name, hm)
	self.write_unit_type user, project_name, type_name, hm do |project, unit_type|
	    if !unit_type.nil?
		unit = find_unit project, unit_type, name
		yield project, unit_type, unit
	    else
		hm[:errors] = [@@errors[:no_unit_type]]
	    end
	end
    end

    def self.access_unit(user, project_name, type_name, name, hm)
	self.access_unit_type user, project_name, type_name, hm do |project, unit_type|
	    #The unit type exists
	    unit = find_unit project, unit_type, name
	    if !unit.nil?
		yield project, unit_type, unit
	    else
		hm[:errors] = [@@error_messages[:no_unit]]
	    end
	end
    end

    def self.get_units(user)
        hm = {:success => true}
	hm[:units] = {}
	get_visible_projects(user).each do |p|
	    hm[:units][p.short_name] = p.units.collect {|unit| unit.value}
	end
        hm.to_json
    end

    def self.get_project_units(user, project_name)
        hm = {:success => false}
	self.process_project(user, project_name, hm) do |project|
	    hm[:success] = true
	    hm[:units] = project.units.collect {|unit| unit.value}
	end
        hm.to_json
    end
    
    def self.get_units_of_type(user, project_name, type_name)
        hm = {:success => false}
	self.process_unit_type(user, project_name, type_name, hm) do |project, type|
	    hm[:success] = true
	    hm[:units] = type.units.collect {|unit| unit.value}
	end
        hm.to_json
    end
    
    def self.get_unit(user, project_name, type_name, name, depth)
        hm = {:success => false}
	self.access_unit(user, project_name, type_name, name, hm) do |project, unit_type, unit|
	    #Let's make a hash!
	    hm[:success] = true
	    hm[:depth] = depth
	    units = unit.get_neighbours depth
	    assocs = Association.get_relationships(units)
	    hm[:units] = {}
	    #units =>
	    Project.where(:id => units.collect{|u| u.project_id}).each do |p|
		hm[:units][p.short_name] = {}
		#<project> =>
		UnitType.where(:id => units.collect {|u| u.unit_type_id}).each do |ut|
		    hm[:units][p.short_name][ut.name] = []
		    #<unit type> => [list of units]
		    units.select {|u| u.project.short_name == p.short_name and u.unit_type_id == ut.id}.each do |u|
			as = {}
			#<association type> => [unit IDs]
			AssociationType.where(:id => assocs.select {|a| a.from_id == u.id }.collect {|a| a.association_type_id}).each do |at|
			    as[at.name] = u.from_associations.select {|a| a.association_type_id == at.id }.collect{|a| units.index(a.to)}
			end
			tus = {}
			#<text unit type> => [content]
			u.text_units.each do |tu|
			    tus[tu.text_unit_type.name] = tu.text
			end
			#[id,name,associations,content]
			hm[:units][p.short_name][ut.name] << [units.index(u), u.value, as, tus]
		    end
		end
	    end
	end
	hm.to_json
    end

    def self.create_unit(user, project_name, type, name)
	hm = {:success => false}
	self.write_unit(user, project_name, type, hm) do |project, type, unit|
	    if unit.nil?
		unit = Unit.new(:project_id => project.id, :unit_type_id => type.id, :value => name)
		if unit.save
		    hm[:success] = true;
		end
	    else
		hm[:errors] = [@@error_messages[:unit_exists]]
	    end
	end
	hm.to_json
    end

    private

    @@error_messages = {
	:unit_exists => "The unit already exists",
	:no_project => "The project does not exist",
	:no_unit_type => "The unit type does not exist",
	:no_unit    => "The unit does not exist",
	:permission => "The user does not have permission to access the project",
	:write_permission => "The user does not have permission to write to the project"
    }

    def self.user_can_write_project?(user, project)
	!user.nil? and !project.project_users.select {|pu| pu.user_id == user.id}.empty?
    end

    def self.user_can_see_project?(user, project)
	(project.public? or (!user.nil? and !project.project_users.select {|pu| pu.user_id == user.id}.empty?))
    end

    def self.get_visible_projects(user)
        if user.nil?
	    return Project.where(:public => true)
        else
	    return user.projects & Project.where(:public => true)
	end
    end

    def self.find_unit(project, type, name)
	Unit.where(:value => name, :unit_type_id => type.id, :project_id => project.id).first
    end

end
