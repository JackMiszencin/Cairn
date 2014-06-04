# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :change_request do |c|
  	# By default sends in coordinates of 176 Brookline Street.
  	c.lonlat 'POINT(-71.105557, 42.359987)'
  end
end
