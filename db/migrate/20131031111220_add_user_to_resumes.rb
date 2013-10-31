class AddUserToResumes < ActiveRecord::Migration
  def change
    add_column :resumes, :user_id, :integer
  end
end
