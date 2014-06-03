class CreateChangeRequests < ActiveRecord::Migration
  def change
    create_table :change_requests do |t|
    	t.point :lonlat, :geographic => true
      t.timestamps
    end
  end
end