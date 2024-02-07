class AddAnswerMmEnglishToMaslas < ActiveRecord::Migration[7.0]
  def change
    add_column :maslas, :answerMMEnglish, :string
  end
end
