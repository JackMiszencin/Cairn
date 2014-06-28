class Atlas < ActiveRecord::Base
	serialize :type_preferences, Array
end
