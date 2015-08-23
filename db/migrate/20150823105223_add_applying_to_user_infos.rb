class AddApplyingToUserInfos < ActiveRecord::Migration
  def change
    add_column :user_infos, :applying, :boolean, :default => true
  end
end
