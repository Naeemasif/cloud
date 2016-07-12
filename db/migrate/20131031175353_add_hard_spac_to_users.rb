class AddHardSpacToUsers < ActiveRecord::Migration
  def change
    add_column :users, :space, :integer, :default => 30000
  end
end
