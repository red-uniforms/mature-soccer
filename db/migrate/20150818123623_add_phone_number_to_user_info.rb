class AddPhoneNumberToUserInfo < ActiveRecord::Migration
  def change
    add_column :user_infos, :phone, :string
    add_column :user_infos, :student_code, :string
    add_column :user_infos, :career, :string

    add_column :teams, :phone, :boolean, :default => false
    add_column :teams, :student_code, :boolean, :default => false
    add_column :teams, :career, :boolean, :default => false
  end
end
