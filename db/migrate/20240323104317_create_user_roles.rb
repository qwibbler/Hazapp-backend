class CreateUserRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :user_roles do |t|
      t.string :name
      t.string :label
      t.boolean :can_delete, default: false
      t.boolean :can_update, default: false
      t.boolean :has_masla, default: false

      t.timestamps
    end
  end
end
