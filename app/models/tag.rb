class Tag < ActiveRecord::Base
	before_save :set_circle

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
end
