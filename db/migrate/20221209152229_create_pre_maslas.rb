class CreatePreMaslas < ActiveRecord::Migration[7.0]
  def change
    create_table :pre_maslas do |t|
      t.references :masla, null: false, foreign_key: true
      t.string :premasla, null: false
      t.string :value, null: false

      t.timestamps
    end
  end
end
