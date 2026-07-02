class CreateVaults < ActiveRecord::Migration[8.1]
  def change
    create_table :vaults do |t|
      t.string :site
      t.string :url
      t.string :login
      t.string :password

      t.timestamps
    end
  end
end
