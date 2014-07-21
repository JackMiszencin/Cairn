class ChangeOrganizationIdToOrganizationCode < ActiveRecord::Migration
  def change
  	remove_column :users, :signup_organization_id
  	add_column :users, :organization_code, :string
  end
end
