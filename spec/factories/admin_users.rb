# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_user do |f|
  	f.sequence(:email) {|x| "admin#{x}@cairn.test"}
  	f.password "password"
  end
end
