class TrnMatRequisitionHdrsController < ApplicationController
  before_action :set_trn_mat_requisition_hdr, only: [:show, :edit, :update, :destroy]

  # GET /trn_mat_requisition_hdrs
  # GET /trn_mat_requisition_hdrs.json
  def index
    @trn_mat_requisition_hdrs = TrnMatRequisitionHdr.all
  end

  # GET /trn_mat_requisition_hdrs/1
  # GET /trn_mat_requisition_hdrs/1.json
  def show
  end

  # GET /trn_mat_requisition_hdrs/new
  def new
    @trn_mat_requisition_hdr = TrnMatRequisitionHdr.new
  end

  # GET /trn_mat_requisition_hdrs/1/edit
  def edit
  end

  # POST /trn_mat_requisition_hdrs
  # POST /trn_mat_requisition_hdrs.json
  def create
    @trn_mat_requisition_hdr = TrnMatRequisitionHdr.new(trn_mat_requisition_hdr_params)

    respond_to do |format|
      if @trn_mat_requisition_hdr.save
        format.html { redirect_to @trn_mat_requisition_hdr, notice: 'Trn mat requisition hdr was successfully created.' }
        format.json { render :show, status: :created, location: @trn_mat_requisition_hdr }
      else
        format.html { render :new }
        format.json { render json: @trn_mat_requisition_hdr.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trn_mat_requisition_hdrs/1
  # PATCH/PUT /trn_mat_requisition_hdrs/1.json
  def update
    respond_to do |format|
      if @trn_mat_requisition_hdr.update(trn_mat_requisition_hdr_params)
        format.html { redirect_to @trn_mat_requisition_hdr, notice: 'Trn mat requisition hdr was successfully updated.' }
        format.json { render :show, status: :ok, location: @trn_mat_requisition_hdr }
      else
        format.html { render :edit }
        format.json { render json: @trn_mat_requisition_hdr.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trn_mat_requisition_hdrs/1
  # DELETE /trn_mat_requisition_hdrs/1.json
  def destroy
    @trn_mat_requisition_hdr.destroy
    respond_to do |format|
      format.html { redirect_to trn_mat_requisition_hdrs_url, notice: 'Trn mat requisition hdr was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trn_mat_requisition_hdr
      @trn_mat_requisition_hdr = TrnMatRequisitionHdr.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trn_mat_requisition_hdr_params
      params.require(:trn_mat_requisition_hdr).permit(:plant, :str_loc, :req_no, :req_dt, :req_shift, :vendor_id, :user_id, :action_status)
    end
end
