class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.integer :level
      t.string :url

      t.timestamps null: false
    end
  end
end
