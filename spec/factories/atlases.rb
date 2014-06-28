# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :atlas, :class => 'Atlas' do |a|
  	a.name 'my atlas'
  end
end
