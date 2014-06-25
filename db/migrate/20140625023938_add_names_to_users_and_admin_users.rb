class AddNamesToUsersAndAdminUsers < ActiveRecord::Migration
  def change
  	add_column :users, :first_name, :string
  	add_column :users, :last_name, :string
  	add_column :admin_users, :first_name, :string
  	add_column :admin_users, :last_name, :string
  end
end
