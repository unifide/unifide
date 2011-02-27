class JSONReply

    def self.unit_reply(units)                
	reply = {}
        assocs = Association.get_relationships(units)
        Project.where(:id => units.collect{|u| u.project_id}).each do |p|
	    reply[p.short_name] = {}
            UnitType.where(:id => units.collect {|u| u.unit_type_id}).each do |ut|
                reply[p.short_name][ut.name] = []
                units.select {|u| u.project.short_name == p.short_name and u.unit_type_id == ut.id}.each do |u|
                    as = {}
                    AssociationType.where(:id => assocs.select {|a| a.from_id == u.id }.collect {|a| a.association_type_id}).each do |at|
                        as[at.name] = u.from_associations.select {|a| a.association_type_id == at.id }.collect{|a| units.index(a.to)}
                    end
                    tus = {}
                    u.text_units.each do |tu|
			tus[tu.text_unit_type.name] = tu.text
                    end
                    reply[p.short_name][ut.name] << [units.index(u), u.value, as, tus]
                end
            end
        end
	reply
    end
end
