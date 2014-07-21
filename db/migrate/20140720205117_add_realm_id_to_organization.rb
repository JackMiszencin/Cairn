class AddRealmIdToOrganization < ActiveRecord::Migration
  def change
  	add_column :organizations, :realm_id, :integer
  end
end
