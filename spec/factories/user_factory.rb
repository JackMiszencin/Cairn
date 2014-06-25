FactoryGirl.define do
	factory :user do |f|
		f.sequence(:email) {|n| "test#{n}@cairn.test"}
	  	f.first_name "Deltron"
  		f.last_name "Zero"
		f.password "password"
	end
end