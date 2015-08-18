class AddFirstNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string, :default => "길동"
    add_column :users, :last_name, :string, :default => "홍"

    remove_column :users, :name
  end
end
