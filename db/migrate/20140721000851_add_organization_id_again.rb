class AddOrganizationIdAgain < ActiveRecord::Migration
  def change
  	add_column :users, :signup_organization_id, :integer
  end
end
