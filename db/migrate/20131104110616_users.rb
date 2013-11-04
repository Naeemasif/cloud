class Users < ActiveRecord::Migration
  def up
    add_column :users, :allocated_space, :string, :default => '0'
  end

  def down
    remove_column :users, :allocated_space
  end
end
