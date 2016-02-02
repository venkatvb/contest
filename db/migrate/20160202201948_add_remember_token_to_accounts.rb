class AddRememberTokenToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :remember_token, :string
  end
end
