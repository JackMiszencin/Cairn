# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tag do |t|
  	t.center 'POINT(-71.105557 42.359987)'
  	t.radius 40.0
  end
end
