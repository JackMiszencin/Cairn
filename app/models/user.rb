class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :organization_users

  has_many :organizations, :through => :organization_users

  def name
  	[self.first_name.to_s, self.last_name.to_s].join(" ")
  end

  def is_org_user(organization_id)
  	organization_user(organization_id).present?
 	end

 	def is_org_manager(organization_id)
  	organization_manager(organization_id).present?
 	end

 	def organization_user(organization_id)
 		(@organization_user || OrganizationUser.where(:user_id => self.id,
 		 													:organization_id => organization_id).last)
 	end

 	def organization_manager(organization_id)
 		(@organization_manager || OrganizationUser.where(:user_id => self.id, 
 													 			:organization_id => organization_id,
 													 			:manager => true).last)
 	end

end
