require 'spec_helper'

describe Tag do
	it 'should set a circle on creation' do
		t = create(:tag)
		expect(t.shape).not_to be_nil
	end
end
