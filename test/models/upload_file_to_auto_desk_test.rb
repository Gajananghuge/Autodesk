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

require 'test_helper'

class UploadFileToAutoDeskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
