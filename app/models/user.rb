class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :organization_users
  has_many :organizations, :through => :organization_users
  # Has a lot of organizations, though, for now, we're just going
  # to keep using a single one for access through the site.

  validates_presence_of :first_name
  validates_presence_of :last_name
  validate :ensure_organization_id

  after_create :create_org_user

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

 	# If the user does not sign up with an organization specified, we create one with the user's name
  # and assign its id as the user's signup_organization_id. create_org_user finishes the process by
  # creating the organization_user join for this organization.
 	def ensure_organization_id
 		ok = false
 		org = nil

 		if self.signup_organization_id
 			org = Organization.where(:id => self.signup_organization_id).last
      if org
        ok = org.signup_codes.include? self.organization_code
        self.errors.add(:organization_code, "code is not valid")
      else
        self.errors.add(:signup_organization_id, "organization does not exist")
      end
 		else
 			org = Organization.new(:name => self.name)
 			ok = org.save
      self.signup_organization_id = org.id
      self.signup_organization_manager = true
 		end
 		return ok
 	end

  # Creates an organization_user for the user's specified signup organization
  # TODO: Write tests for this function
  def create_org_user
    org_user = OrganizationUser.new(:organization_id => self.signup_organization_id, :user_id => self.id, :manager => self.signup_organization_manager)
    ok = org_user.save
    return ok
  end

  # This is going to serve as a major utility early on, since we're only going to really be letting
  # a user have access to one organization for the time being.
  # TODO: Write tests for this function
  def first_organization
    return self.organizations.first
  end

end
