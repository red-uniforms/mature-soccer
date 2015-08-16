class AddUsersCountToTeams < ActiveRecord::Migration
  def self.up
    add_column :teams, :users_count, :integer, :default => 0

    Team.reset_column_information
    Team.all.each do |p|
      p.update_attribute :users_count, p.users.length
    end
  end

  def self.down
    remove_column :teams, :users_count
  end
end
