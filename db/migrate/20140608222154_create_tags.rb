class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
    	t.string :name
    	t.point :center, :geographic => true
    	t.float :radius
    	t.polygon :shape, :geographic => true

      t.timestamps
    end
  end
end
