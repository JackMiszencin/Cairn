class SetDefaultOnOrganizationUserManager < ActiveRecord::Migration
  def change
  	remove_column :organization_users, :manager
  	add_column :organization_users, :manager, :boolean, :default => false
  end
end
