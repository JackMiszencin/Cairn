class AddOrgIdAndTagTypeIdToTag < ActiveRecord::Migration
  def change
  	add_column :tags, :tag_type_id, :integer
  	add_column :tags, :organization_id, :integer
  end
end
