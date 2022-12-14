class CreateMaslas < ActiveRecord::Migration[7.0]
  def change
    create_table :maslas do |t|
      t.string :uid, null: false, index: { unique: true }
      t.string :typeOfInput, default: 'DATE_ONLY'
      t.string :typeOfMasla, default: 'MUTADA'
      t.string :entries, array: true, default: []
      t.string :answerUrdu, default: ''
      t.string :answerEnglish, default: ''

      t.timestamps
    end
  end
end
