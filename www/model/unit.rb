class Unit < ActiveRecord::Base

    belongs_to :project
    belongs_to :unit_type
    has_many :from_associations, :class_name => 'Association', :foreign_key => 'from_id'
    has_many :to_associations, :class_name => 'Association', :foreign_key => 'to_id'
    has_many :text_units

    def to_json()
	{:project => project.short_name, :type => unit_type.name, :name => value}
    end	

    def get_neighbours(depth)
	#First let's et a list of all the units we want to put in the JSON
	units = [self]
	prev = [self]
	#For each layer we want to gather all the 'to's of each unit in it
	for d in 1..depth do
	    curr = []
	    prev.each do |unit|
		curr = curr + unit.from_associations.collect{|a| a.to}.select {|u| !units.include? u}
		curr = curr + unit.to_associations.collect{|a| a.from}.select {|u| !units.include? u}
	    end
	    #Units in a layer may share children so remove duplicates
	    curr.uniq!
	    units = units + curr
	    prev = curr
	end
	#units will only contain distinct units at this point as it was a precondition for anythign being added to it
	return units
    end

end
