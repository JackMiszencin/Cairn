class AddSignupCodesToOrganization < ActiveRecord::Migration
  def change
  	add_column :organizations, :signup_codes, :text
  end
end
