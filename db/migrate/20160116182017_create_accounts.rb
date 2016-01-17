class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :email
      t.string :college
      t.string :department
      t.string :year
      t.string :phone
      t.integer :level

      t.timestamps null: false
    end
  end
end
