class AddRegisterNumberToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :register_number, :string
  end
end
