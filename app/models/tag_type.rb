class TagType < ActiveRecord::Base
	has_many :tags
	validates_presence_of :name
	validates :radius, :presence => true, :numericality => true

	def self.private
		TagType.where("organization_id IS NOT NULL")
	end
end
