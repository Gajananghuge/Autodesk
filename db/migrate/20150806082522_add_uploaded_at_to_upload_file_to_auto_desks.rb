class AddUploadedAtToUploadFileToAutoDesks < ActiveRecord::Migration
  def change
    add_column :upload_file_to_auto_desks, :uploaded_at, :datetime
  end
end
