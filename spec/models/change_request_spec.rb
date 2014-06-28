require 'spec_helper'

# some standard values
old_x = -71.105557
old_y = 42.359987
new_radius = 70
new_x = -122
new_y = 47
new_point = ['POINT(', new_x.to_s, ' ', new_y.to_s, ')'].join('')
new_name = 'thing'
new_polygon = 'POLYGON((-123 46, -121 46, -122 48))'



describe ChangeRequest do
	describe 'lonlat' do
	  it 'should return the correct longitude and latitude' do
	  	create_request
	  	expect(@change_request.center.x).to eq old_x
	  	expect(@change_request.center.y).to eq old_y
	  end
	end

	describe '#approve' do
		before(:each) do
			create_request(:center => new_point,
											:radius => new_radius,
											:name => new_name, 
											:shape => new_polygon)
		end

		it 'should transfer all changes to tag' do
			@change_request.approve
			expect(@change_request.tag.center.x).to eq new_x
			expect(@change_request.tag.center.y).to eq new_y
			expect(@change_request.tag.radius).to eq new_radius
			expect(@change_request.tag.shape).to_not eq nil
			# TODO: Write a better test for the above. None of the methods seem to be working on
			# my shapes. Figure out which ones you can use, and then test them out.
		end

		it 'should return leave field as-is if left blank on change request' do
			@change_request.update_attributes(:center => nil)
			@change_request.approve
			expect(@change_request.tag.center.x).to eq old_x
			expect(@change_request.tag.center.y).to eq old_y
		end
	end
end

def create_request(attrs={})
	@change_request = create(:change_request)
	create_tag
	@change_request.update_attributes(:tag_id => @tag.id)
	@change_request.update_attributes(attrs)
end

def create_tag(attrs={})
	@tag = create(:tag)
end