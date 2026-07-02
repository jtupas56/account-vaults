class AddUserToVaults < ActiveRecord::Migration[8.1]
  def change
    add_reference :vaults, :user, null: false, foreign_key: true
  end
end
