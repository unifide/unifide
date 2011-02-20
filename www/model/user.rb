require 'bcrypt'

class User < ActiveRecord::Base
    
    include BCrypt

    has_many :user_projects, :class_name => 'ProjectUser', :foreign_key => 'user_id'

    def password
        @password ||= Password.new(password_hash)
    end

    def password=(new_password)
        @password = Password.create(new_password)
        self.password_hash = @password
    end

    def name
        "#{first_name} #{second_name}"
    end

end
