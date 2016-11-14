class AddPrimaryRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :primary_role, :integer
  end
end
