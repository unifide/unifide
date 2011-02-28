require 'json'
require 'model'

class JSONReply
    
    def self.user_can_see_project?(user, project)
	(project.public? or (!user.nil? and project.project_users.select {|pu| pu.user_id == user.id}.empty?))
    end

    def self.get_visible_projects(user)
        if user.nil?
	    return Project.where(:public => true)
        else
	    return user.projects & Project.where(:public => true)
	end
    end

    def self.get_unit(project, type, name)
	Unit.where(:value => name, :unit_type_id => type.id, :project_id => project.id).first
    end
    
    def self.unit(user, project_name, type_name, name, depth=1)
        hm ||= {:success => false}
        project = Project.find_by_short_name project_name
	if !project.nil?
	    #The project exists
            if user_can_see_project? user, project
		#The user can access the project
		unit_type = UnitType.find_by_name(type_name)
		if !unit_type.nil?
		    #The unit type exists
		    unit = get_unit project, unit_type, name
		    if !unit.nil?
			#The unit exists
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
			#ping! hash is done
		    else
			hm[:errors] = ["The unit type does not exist"]
		    end
                else
		    hm[:errors] = ["The unit does not exist"]
	        end
            else
	        hm[:errors] = ["The user does not have permission to access the requested unit"]
	    end
	else
	    hm[:errors] = ["The project does not exist"]
	end
        hm.to_json
    end

end
