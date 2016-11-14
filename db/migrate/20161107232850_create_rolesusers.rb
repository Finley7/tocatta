class CreateRolesusers < ActiveRecord::Migration
  def change
    create_table :rolesusers do |t|

      t.timestamps null: false
    end
  end
end
