class CreateTagTypes < ActiveRecord::Migration
  def change
    create_table :tag_types do |t|
    	t.string :name
    	t.integer :organization_id
    	t.float :radius
    	t.string :description
      t.timestamps
    end

    add_index :tag_types, :name
    add_index :tag_types, :organization_id
  end
end
