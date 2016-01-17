class AddAnswerToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :answer, :string
  end
end
