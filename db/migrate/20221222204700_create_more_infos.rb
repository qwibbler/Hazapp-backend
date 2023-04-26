class CreateMoreInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :more_infos do |t|
      t.references :masla, null: false, foreign_key: true
      t.string :info, null: false
      t.string :value, null: false

      t.timestamps
    end

    enable_extension 'tablefunc' unless extension_enabled?('tablefunc')
  end
end
