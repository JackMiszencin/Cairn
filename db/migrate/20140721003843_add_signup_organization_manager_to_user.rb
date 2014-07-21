class AddSignupOrganizationManagerToUser < ActiveRecord::Migration
  def change
  	add_column :users, :signup_organization_manager, :boolean
  end
end
