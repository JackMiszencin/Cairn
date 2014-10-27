class Tag < ActiveRecord::Base
	before_save :set_circle
	belongs_to :tag_typeexi

	scope :intersects_geometry, -> (geo) {
		where(%{
			ST_Intersects(
				tags.shape,
				ST_GeographyFromText('SRID=4326;%s')
			)
		} % [geo])
	}

	# Tag.declare_get_relevance must be run before this scope is used
	# TODO: Write test to ensure this is returning in descending order
	scope :sort_by_relevance, -> (geo) {
		order(%{get_relevance(ST_GeographyFromText('SRID=4326;%s'), tags.shape) DESC} % [geo])
	}

	# returns an array of all tags which intersect current tag, sorted in order of 
	def relevant_tags
		Tag.declare_get_relevance
		Tag.intersects_geometry(self.shape).sort_by_relevance(self.shape).to_a
	end

	# Must be run before any SQL query using the get_relevance function
	def self.declare_get_relevance
		ActiveRecord::Base.connection.execute("
			DROP FUNCTION IF EXISTS get_relevance(geoOne GEOGRAPHY, geoTwo GEOGRAPHY);
			CREATE FUNCTION get_relevance(geoOne GEOGRAPHY, geoTwo GEOGRAPHY) RETURNS FLOAT AS $$
			DECLARE
				sharedArea FLOAT;
				relevanceScore FLOAT;
			BEGIN
				sharedArea := (st_area(ST_Intersection(geoOne, geoTwo)));
				relevanceScore := (sharedArea * sharedArea) / (st_area(geoOne) * st_area(geoTwo));
				RETURN relevanceScore;
			END;
			$$ LANGUAGE plpgsql;
		");
	end

	def set_circle
		ok = true
		if self.center == nil
			ok = false
			self.errors.add(:center, "Must have center point")
		end
		if self.radius == nil
			ok = false
			self.errors.add(:radius, "Must have radius")
		end
		self.shape = self.center.buffer(self.radius) if ok
		return ok
	end

	def deg_per_met
		r = 6371000
		latrad = (90 - self.center.y).abs * (2*Math::PI/360) # Converts latitudinal degrees into radians for the sake of sake of Ruby's sin function.
		rprime = r * Math.sin(latrad) # Using SOHCAHTOA to get the horizontal cross-sectional radius of the earth at the user's latitude.
		return 360 / (rprime*2*Math::PI) # Takes this radius and uses it to get the cross-sectional circumference at that point in meters
		# and return 360 degrees by this circumferences to get degrees per meter.
	end

end
