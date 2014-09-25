class Atlas < ActiveRecord::Base
	serialize :type_filters, Array
	belongs_to :realm, :class_name => 'Tag'
	accepts_nested_attributes_for :realm

end
