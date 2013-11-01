class AddFileSizeToResumes < ActiveRecord::Migration
  def change
    add_column :resumes, :file_size, :float,  :precision => 4 , :scale => 2
  end
end
