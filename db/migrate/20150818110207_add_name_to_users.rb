class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, :default => "홍길동"
  end
end
