class ProjectUser < ActiveRecord::Base

    set_table_name 'projects_users'

    belongs_to :project
    belongs_to :user

end
