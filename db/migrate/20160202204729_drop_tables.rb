class DropTables < ActiveRecord::Migration
  def change
  	drop_table :accounts, force: :cascade
  end
end
