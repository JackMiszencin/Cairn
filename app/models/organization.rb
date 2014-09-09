class Organization < ActiveRecord::Base
	serialize :signup_codes, Array
	has_many :organization_users
	has_many :users, :through => :organization_users
	has_many :atlases
	belongs_to :realm, :class_name => :tag

	def tag_types
		TagType.where('organization_id IS NULL OR organization_id=?', self.id);
	end
end
