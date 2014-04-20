FactoryGirl.define do
	factory :user do |f|
		f.sequence(:email) {|n| "test#{n}@cairn.test"}
		f.password "password"
	end
end