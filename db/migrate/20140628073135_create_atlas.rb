class CreateAtlas < ActiveRecord::Migration
  def change
    create_table :atlases do |t|
    	t.integer :realm_id
    	t.integer :organization_id
    	t.string :name
    	t.text :type_filters
      t.timestamps
    end
  end
end
