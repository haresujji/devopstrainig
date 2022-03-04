class TrnWhIssueHdrsController < ApplicationController
  before_action :set_trn_wh_issue_hdr, only: [:show, :edit, :update, :destroy]

  # GET /trn_wh_issue_hdrs
  # GET /trn_wh_issue_hdrs.json
  def index
    @trn_wh_issue_hdrs = TrnWhIssueHdr.all
  end

  # GET /trn_wh_issue_hdrs/1
  # GET /trn_wh_issue_hdrs/1.json
  def show
  end

  # GET /trn_wh_issue_hdrs/new
  def new
    @trn_wh_issue_hdr = TrnWhIssueHdr.new
  end

  # GET /trn_wh_issue_hdrs/1/edit
  def edit
  end

  # POST /trn_wh_issue_hdrs
  # POST /trn_wh_issue_hdrs.json
  def create
    @trn_wh_issue_hdr = TrnWhIssueHdr.new(trn_wh_issue_hdr_params)

    respond_to do |format|
      if @trn_wh_issue_hdr.save
        format.html { redirect_to @trn_wh_issue_hdr, notice: 'Trn wh issue hdr was successfully created.' }
        format.json { render :show, status: :created, location: @trn_wh_issue_hdr }
      else
        format.html { render :new }
        format.json { render json: @trn_wh_issue_hdr.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trn_wh_issue_hdrs/1
  # PATCH/PUT /trn_wh_issue_hdrs/1.json
  def update
    respond_to do |format|
      if @trn_wh_issue_hdr.update(trn_wh_issue_hdr_params)
        format.html { redirect_to @trn_wh_issue_hdr, notice: 'Trn wh issue hdr was successfully updated.' }
        format.json { render :show, status: :ok, location: @trn_wh_issue_hdr }
      else
        format.html { render :edit }
        format.json { render json: @trn_wh_issue_hdr.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trn_wh_issue_hdrs/1
  # DELETE /trn_wh_issue_hdrs/1.json
  def destroy
    @trn_wh_issue_hdr.destroy
    respond_to do |format|
      format.html { redirect_to trn_wh_issue_hdrs_url, notice: 'Trn wh issue hdr was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trn_wh_issue_hdr
      @trn_wh_issue_hdr = TrnWhIssueHdr.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trn_wh_issue_hdr_params
      params.require(:trn_wh_issue_hdr).permit( :plant,:str_loc,:to_plant,:to_str_loc,:req_no,:req_dt,:sequence_number,:mat_group,:mat_desc,:mat_code,:mat_uom,:required_qty,:issue_docno,:Issue_docdt,:issued_qty,:user_id,:action_status)
    end
end
