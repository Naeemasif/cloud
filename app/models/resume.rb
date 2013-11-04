class Resume < ActiveRecord::Base
  attr_accessible :attachment, :name, :file_size
  mount_uploader :attachment, AttachmentUploader # Tells rails to use this uploader for this model.
  belongs_to :user
  validates_presence_of :attachment
  validates_uniqueness_of :name
  before_save :update_attachment_attributes
  private


  def update_attachment_attributes
    if attachment.present?
      self.file_size = attachment.file.size
    end
  end
  before_create do
    self.name = self.attachment.original_file
  end
end
