require 'spec_helper'

describe ChangeRequest, 'lonlat' do
  it 'should return the correct longitude and latitude' do
  	c = create(:change_request)
  	expect(c.lonlat.x).to eq 42.359987
  	expect(c.lonlat.y).to eq -71.105557
  end
end
