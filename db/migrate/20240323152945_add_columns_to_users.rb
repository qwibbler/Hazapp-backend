class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    hazapper_role = UserRole.find_by(name: 'hazapper')
    add_reference :users, :user_role, null: true, foreign_key: true, default: hazapper_role.id
    add_reference :users, :masla, null: true, foreign_key: true
  end
end
