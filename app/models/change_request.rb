class ChangeRequest < ActiveRecord::Base
	belongs_to :user
	belongs_to :tag

	# Takes in a distance in meters. Remember, feed in the x-coordinate first, then the y.
	scope :within_distance, -> (longitude, latitude, distance) {
		where(%{
			ST_DWithin(
				change_requests.lonlat,
				ST_GeographyFromText('SRID=4326;POINT(%f %f)'),
				%d
			)
		} % [longitude, latitude, distance])
	}

	scope :unresolved, -> {where('resolved IS NOT TRUE')}

	def approve
		ok = self.tag.update_attributes(:center => self.lonlat)
	end
end
