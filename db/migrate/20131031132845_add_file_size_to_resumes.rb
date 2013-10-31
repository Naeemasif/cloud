class AddFileSizeToResumes < ActiveRecord::Migration
  def change
    add_column :resumes, :file_size, :float
  end
end
