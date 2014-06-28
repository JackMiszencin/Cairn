require 'spec_helper'

describe AdminUser, 'validations work' do
  it 'only saves if password is provided' do
  	u = AdminUser.create(:email => "something@cairn.test", :password => nil)
  	u.should have(1).error_on(:password)
  end
end
