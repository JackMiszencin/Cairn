class AddResolvedToChangeRequest < ActiveRecord::Migration
  def change
  	add_column :change_requests, :resolved, :boolean
  end
end
