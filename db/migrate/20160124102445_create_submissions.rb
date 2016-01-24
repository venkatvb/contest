class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.references :account, index: true, foreign_key: true
      t.references :problem, index: true, foreign_key: true
      t.datetime :time
      t.string :answer

      t.timestamps null: false
    end
  end
end
