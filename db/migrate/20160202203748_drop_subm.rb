class DropSubm < ActiveRecord::Migration
  def change
  	drop_table :submissions
  	drop_table :accounts
  end
end
