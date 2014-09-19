class AddGeoFilterToAtlas < ActiveRecord::Migration
  def change
  	add_column :atlases, :geo_filter, :boolean
  end
end
