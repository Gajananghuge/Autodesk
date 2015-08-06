# == Schema Information
#
# Table name: upload_file_to_auto_desks
#
#  id                     :integer          not null, primary key
#  filename               :string
#  content_type           :string
#  file_contents          :binary
#  sync_with_auto_desk_at :string
#  auto_desk_url          :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class UploadFileToAutoDesk < ActiveRecord::Base

	def initialize(params = {})
		@file = params.delete(:file)
		super
		if @file
			self.filename = sanitize_filename(@file.original_filename)
			self.content_type = @file.content_type
			self.file_contents = @file.read
		end
	end

	private

	def sanitize_filename(filename)     
	return File.basename(filename)
	end
end
