class Organization < ActiveRecord::Base
	serialize :signup_codes, Array
	has_many :organization_users
	has_many :users, :through => :organization_users
	has_many :atlases
	belongs_to :realm
end
