class AddNameToUser < ActiveRecord::Migration
  def up
    add_column :users, :name, :string

    User.all.each do |u|
      u.update_attributes! :name => u.last_name + u.first_name
    end

    remove_column :users, :first_name
    remove_column :users, :last_name
  end

  def down
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string

    User.all.each do |u|
      u.update_attributes! :first_name => u.name[0]
      u.update_attributes! :last_name => u.name[1..-1]
    end

    remove_column :users, :name
  end
end
