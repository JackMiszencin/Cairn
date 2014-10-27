require 'spec_helper'

describe Tag do
	it 'should set a circle on creation' do
		t = create(:tag)
		expect(t.shape).not_to be_nil
	end

	describe '#relevant_tags' do
		ashford_home = nil
		ashford_closer = nil
		ashford_further = nil
		before(:each) do
			# The first is the tag we want to find relevant tags for. Both of the second ones
			# intersect the first, but as names indicate, the second is closer (and thus more
			# relevant).
			ashford_home = create(:tag, :center => 'POINT(41.893966 -72.131881)', :radius => 5000.0)
			ashford_closer = create(:tag, :center => 'POINT(41.894222 -72.121238)', :radius => 5000.0)
			ashford_further = create(:tag, :center => 'POINT(41.894989 -72.111625)', :radius => 5000.0)
		end

		it 'should return all relevant tags' do
			relevant_tags = ashford_home.relevant_tags
			expect(relevant_tags.length).to eq 2
			expect(relevant_tags[0].id).to eq ashford_closer.id
			expect(relevant_tags[1].id).to eq ashford_further.id			
		end
	end
end
