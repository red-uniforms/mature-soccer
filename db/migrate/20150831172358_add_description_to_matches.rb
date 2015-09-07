class AddDescriptionToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :description, :string
    add_column :matches, :half, :integer
    add_column :matches, :extra, :integer
    add_column :matches, :penalty, :boolean
  end
end
