class WhStoHdrsController < ApplicationController
  before_action :set_wh_sto_hdr, only: [:show, :edit, :update, :destroy]

  # GET /wh_sto_hdrs
  # GET /wh_sto_hdrs.json
  def index
    @wh_sto_hdrs = WhStoHdr.all
  end

  # GET /wh_sto_hdrs/1
  # GET /wh_sto_hdrs/1.json
  def show
  end

  # GET /wh_sto_hdrs/new
  def new
    @wh_sto_hdr = WhStoHdr.new
  end

  # GET /wh_sto_hdrs/1/edit
  def edit
  end

  # POST /wh_sto_hdrs
  # POST /wh_sto_hdrs.json
  def create
    @wh_sto_hdr = WhStoHdr.new(wh_sto_hdr_params)

    respond_to do |format|
      if @wh_sto_hdr.save
        format.html { redirect_to @wh_sto_hdr, notice: 'Wh sto hdr was successfully created.' }
        format.json { render :show, status: :created, location: @wh_sto_hdr }
      else
        format.html { render :new }
        format.json { render json: @wh_sto_hdr.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wh_sto_hdrs/1
  # PATCH/PUT /wh_sto_hdrs/1.json
  def update
    respond_to do |format|
      if @wh_sto_hdr.update(wh_sto_hdr_params)
        format.html { redirect_to @wh_sto_hdr, notice: 'Wh sto hdr was successfully updated.' }
        format.json { render :show, status: :ok, location: @wh_sto_hdr }
      else
        format.html { render :edit }
        format.json { render json: @wh_sto_hdr.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wh_sto_hdrs/1
  # DELETE /wh_sto_hdrs/1.json
  def destroy
    @wh_sto_hdr.destroy
    respond_to do |format|
      format.html { redirect_to wh_sto_hdrs_url, notice: 'Wh sto hdr was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wh_sto_hdr
      @wh_sto_hdr = WhStoHdr.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wh_sto_hdr_params
      params.fetch(:wh_sto_hdr, {})
    end
end
