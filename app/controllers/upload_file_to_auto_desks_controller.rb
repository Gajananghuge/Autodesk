class UploadFileToAutoDesksController < ApplicationController
  require 'open-uri'
  before_filter :authenticate_user!
  before_action :set_upload_file_to_auto_desk, only: [:show, :edit, :update, :destroy]

  # GET /upload_file_to_auto_desks
  # GET /upload_file_to_auto_desks.json
  def index
    @upload_file_to_auto_desks = UploadFileToAutoDesk.all
  end

  # GET /upload_file_to_auto_desks/1
  # GET /upload_file_to_auto_desks/1.json
  def show

  end

  # GET /upload_file_to_auto_desks/new
  def new
    @upload_file_to_auto_desk = UploadFileToAutoDesk.new
  end

  # GET /upload_file_to_auto_desks/1/edit
  def edit
  end

  # POST /upload_file_to_auto_desks
  # POST /upload_file_to_auto_desks.json
  def create
    @upload_file_to_auto_desk = UploadFileToAutoDesk.new(upload_file_to_auto_desk_params)

    respond_to do |format|
      if @upload_file_to_auto_desk.save
        format.html { redirect_to '/upload_file_to_auto_desks', notice: 'Upload file to auto desk was successfully created.' }
        format.json { render :show, status: :created, location: @upload_file_to_auto_desk }
      else
        format.html { render :new }
        format.json { render json: @upload_file_to_auto_desk.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /upload_file_to_auto_desks/1
  # PATCH/PUT /upload_file_to_auto_desks/1.json
  def update
    respond_to do |format|
      if @upload_file_to_auto_desk.update(upload_file_to_auto_desk_params)
        format.html { redirect_to @upload_file_to_auto_desk, notice: 'Upload file to auto desk was successfully updated.' }
        format.json { render :show, status: :ok, location: @upload_file_to_auto_desk }
      else
        format.html { render :edit }
        format.json { render json: @upload_file_to_auto_desk.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /upload_file_to_auto_desks/1
  # DELETE /upload_file_to_auto_desks/1.json
  def destroy
    @upload_file_to_auto_desk.destroy
    respond_to do |format|
      format.html { redirect_to upload_file_to_auto_desks_url, notice: 'Upload file to auto desk was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def autodeskfile
    logger.info('======================================');
    @file_data = UploadFileToAutoDesk.find(params['file']['id'])
    key = '86wrqgM3ZtkUOEsujKtJgREXmk2zT6SR'                                           #credentials from developer.autodesk.com
    secret = 'Bb36nwEVJYGccmCF'
    name = 'vueops'                                       #the name you want to give your bucket
    policy = 'transient'                                      #the retention policy you want to register your bucket with
    #filepath = "#{Rails.root}/public/DWG-Test.dwg"                               #such as "#{Rails.root}/public/Test.dwg"
    filepath = "https://s3-us-west-2.amazonaws.com/nileshk/DWG-Test.dwg"  #URI.parse('https://s3-us-west-2.amazonaws.com/nileshk/DWG-Test.dwg')
    filename = "DWG-Test.dwg"                     #such as "Test.dwg"
    filesize =  1787064                                
    
    token = Adn_Viewer.token(key, secret)["access_token"]     #gives you an access token
    binding.pry
    supported_formats = Adn_Viewer.supported_formats(token)   #fills the variable supported_formats with all formats that the viewer supports (in json format)

    Adn_Viewer.create_bucket(token, name, policy)             #creates the bucket
    name = Adn_Viewer.check_bucket(token, name)["key"]        #checks status and returns bucket name
    urn = Adn_Viewer.upload_file(token, name, filename, filepath, filesize)["objects"][0].first.to_s      #upload the file you want to view
    urn = urn[8...-2]                                         #formats the urn correctly
    urn = Base64.urlsafe_encode64(urn)                        #encodes the urn to allow translation 
    binding.pry
    Adn_Viewer.register(token, urn)                           #registers for translation

    gon.token = token                                         #sets variables up to use in javascript for the viewer
    gon.urn = urn        

    @file_data.update_attributes :auto_desk_url => urn, :uploaded_at => DateTime.now     #"dXJuOmFkc2sub2JqZWN0czpvcy5vYmplY3Q6dnVlb3BzL0RXRy1UZXN0LmR3Zw=="

    render :nothing => true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_upload_file_to_auto_desk
      @upload_file_to_auto_desk = UploadFileToAutoDesk.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def upload_file_to_auto_desk_params
      params.require(:upload_file_to_auto_desk).permit(:file)
      #params.require(:upload_file_to_auto_desk).permit(:filename, :content_type, :file_contents, :sync_with_auto_desk_at, :auto_desk_url)
    end
end
