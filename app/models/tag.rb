class Tag < ActiveRecord::Base
	before_save :set_circle
	belongs_to :tag_typeexi

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
