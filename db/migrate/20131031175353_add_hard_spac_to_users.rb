class AddHardSpacToUsers < ActiveRecord::Migration
  def change
    add_column :users, :space, :integer, :default => 5021
  end
end
