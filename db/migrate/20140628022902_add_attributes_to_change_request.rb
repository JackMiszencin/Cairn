class AddAttributesToChangeRequest < ActiveRecord::Migration
  def change
  	remove_column :change_requests, :lonlat
  	add_column :change_requests, :center, :point, :geographic => true
  	add_column :change_requests, :shape, :polygon, :geographic => true
  	add_column :change_requests, :radius, :float
  	add_column :change_requests, :name, :string
  end
end
