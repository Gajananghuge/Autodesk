class CreateUploadFileToAutoDesks < ActiveRecord::Migration
  def change
    create_table :upload_file_to_auto_desks do |t|
      t.string :filename
      t.string :content_type
      t.binary :file_contents
      t.string :sync_with_auto_desk_at
      t.string :auto_desk_url

      t.timestamps null: false
    end
  end
end
