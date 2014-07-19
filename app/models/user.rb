class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :organization_users
  has_many :organizations, :through => :organization_users

  after_create :ensure_organization

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

 	# Makes sure that a new user has at least one organization_user. If not assigned an
 	# organization on signup, the method creates an organization with the user's name.
 	def ensure_organization
 		ok = false
 		org = nil

 		if self.signup_organization_id
 			ok = org = Organization.find(self.signup_organization_id)
 		else
 			org = Organization.new(:name => self.name)
 			ok = org.save
 		end
		if ok
			org_user = OrganizationUser.new(:organization_id => org.id, :user_id => self.id, :manager => true)
			ok = org_user.save
		end
 		return ok
 	end

end
