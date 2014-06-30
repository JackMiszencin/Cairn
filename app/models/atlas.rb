class Atlas < ActiveRecord::Base
	serialize :type_filters, Array
end
