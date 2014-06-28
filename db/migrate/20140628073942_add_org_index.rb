class AddOrgIndex < ActiveRecord::Migration
  def change
  	add_index :atlases, :organization_id
  end
end
