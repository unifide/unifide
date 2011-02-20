class Project < ActiveRecord::Base

    has_many :project_users, :foreign_key => 'project_id'

end
