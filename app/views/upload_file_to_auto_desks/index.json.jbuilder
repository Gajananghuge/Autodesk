json.array!(@upload_file_to_auto_desks) do |upload_file_to_auto_desk|
  json.extract! upload_file_to_auto_desk, :id, :filename, :content_type, :file_contents, :sync_with_auto_desk_at, :auto_desk_url
  json.url upload_file_to_auto_desk_url(upload_file_to_auto_desk, format: :json)
end
