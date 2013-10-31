class Resume < ActiveRecord::Base
  attr_accessible :attachment, :name
  mount_uploader :attachment, AttachmentUploader # Tells rails to use this uploader for this model.

  belongs_to :user
  private
  before_create do
    self.name = self.attachment.original_file
  end
end
