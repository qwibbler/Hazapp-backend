class CreateMaslas < ActiveRecord::Migration[7.0]
  def change
    create_table :maslas do |t|
      t.string :uid, null: false, index: { unique: true }
      t.string :typeOfInput, default: 'dateOnly'
      t.string :typeOfMasla, default: 'mutada'
      t.string :entries, array: true, default: []
      t.text :answerEnglish, default: ''
      t.text :answerUrdu, default: ''

      t.timestamps
    end
  end
end
