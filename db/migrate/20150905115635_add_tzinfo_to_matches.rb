class AddTzinfoToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :tzinfo, :integer
  end
end
