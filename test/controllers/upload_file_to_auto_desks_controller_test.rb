require 'test_helper'

class UploadFileToAutoDesksControllerTest < ActionController::TestCase
  setup do
    @upload_file_to_auto_desk = upload_file_to_auto_desks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:upload_file_to_auto_desks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create upload_file_to_auto_desk" do
    assert_difference('UploadFileToAutoDesk.count') do
      post :create, upload_file_to_auto_desk: { auto_desk_url: @upload_file_to_auto_desk.auto_desk_url, content_type: @upload_file_to_auto_desk.content_type, file_contents: @upload_file_to_auto_desk.file_contents, filename: @upload_file_to_auto_desk.filename, sync_with_auto_desk_at: @upload_file_to_auto_desk.sync_with_auto_desk_at }
    end

    assert_redirected_to upload_file_to_auto_desk_path(assigns(:upload_file_to_auto_desk))
  end

  test "should show upload_file_to_auto_desk" do
    get :show, id: @upload_file_to_auto_desk
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @upload_file_to_auto_desk
    assert_response :success
  end

  test "should update upload_file_to_auto_desk" do
    patch :update, id: @upload_file_to_auto_desk, upload_file_to_auto_desk: { auto_desk_url: @upload_file_to_auto_desk.auto_desk_url, content_type: @upload_file_to_auto_desk.content_type, file_contents: @upload_file_to_auto_desk.file_contents, filename: @upload_file_to_auto_desk.filename, sync_with_auto_desk_at: @upload_file_to_auto_desk.sync_with_auto_desk_at }
    assert_redirected_to upload_file_to_auto_desk_path(assigns(:upload_file_to_auto_desk))
  end

  test "should destroy upload_file_to_auto_desk" do
    assert_difference('UploadFileToAutoDesk.count', -1) do
      delete :destroy, id: @upload_file_to_auto_desk
    end

    assert_redirected_to upload_file_to_auto_desks_path
  end
end
