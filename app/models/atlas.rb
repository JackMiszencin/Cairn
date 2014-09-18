class Atlas < ActiveRecord::Base
	serialize :type_filters, Array
	belongs_to :realm, :class_name => 'Tag'

end
