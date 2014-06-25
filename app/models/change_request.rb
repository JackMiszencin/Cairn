class ChangeRequest < ActiveRecord::Base

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
end
