class CreatePermissionRoles < ActiveRecord::Migration
  def change
    create_join_table :roles, :permissions do |t|
      t.index :role_id
      t.index :permission_id
    end
  end
end
