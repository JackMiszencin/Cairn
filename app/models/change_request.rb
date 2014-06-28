class ChangeRequest < ActiveRecord::Base
	belongs_to :user
	belongs_to :tag

	@@tag_attributes = ['center', 'radius', 'shape', 'name']

	# Takes in a distance in meters. Remember, feed in the x-coordinate first, then the y.
	scope :within_distance, -> (longitude, latitude, distance) {
		where(%{
			ST_DWithin(
				change_requests.center,
				ST_GeographyFromText('SRID=4326;POINT(%f %f)'),
				%d
			)
		} % [longitude, latitude, distance])
	}

	scope :unresolved, -> {where('resolved IS NOT TRUE')}

	def approve
		ok = self.tag.update_attributes(self.change_attributes)
	end

	def change_attributes
		self.attributes.select{|k,v| ( @@tag_attributes.include?(k.to_s) && !v.nil? )}
	end
end
