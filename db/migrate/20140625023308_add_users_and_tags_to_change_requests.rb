class AddUsersAndTagsToChangeRequests < ActiveRecord::Migration
  def change
  	add_column :change_requests, :user_id, :integer
  	add_column :change_requests, :tag_id, :integer
  end
end
