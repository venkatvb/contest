class AddTimeToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :time, :timestamp
  end
end
