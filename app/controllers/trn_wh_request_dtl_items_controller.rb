class TrnWhRequestDtlItemsController < ApplicationController
  before_action :set_trn_wh_request_dtl_item, only: [:show, :edit, :update, :destroy]

  # GET /trn_wh_request_dtl_items
  # GET /trn_wh_request_dtl_items.json
  def index
    @trn_wh_request_dtl_items = TrnWhRequestDtlItem.all
  end

  # GET /trn_wh_request_dtl_items/1
  # GET /trn_wh_request_dtl_items/1.json
  def show
  end

  # GET /trn_wh_request_dtl_items/new
  def new
    @trn_wh_request_dtl_item = TrnWhRequestDtlItem.new
  end

  # GET /trn_wh_request_dtl_items/1/edit
  def edit
  end

  # POST /trn_wh_request_dtl_items
  # POST /trn_wh_request_dtl_items.json
  def create
    @trn_wh_request_dtl_item = TrnWhRequestDtlItem.new(trn_wh_request_dtl_item_params)

    respond_to do |format|
      if @trn_wh_request_dtl_item.save
        format.html { redirect_to @trn_wh_request_dtl_item, notice: 'Trn wh request dtl item was successfully created.' }
        format.json { render :show, status: :created, location: @trn_wh_request_dtl_item }
      else
        format.html { render :new }
        format.json { render json: @trn_wh_request_dtl_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trn_wh_request_dtl_items/1
  # PATCH/PUT /trn_wh_request_dtl_items/1.json
  def update
    respond_to do |format|
      if @trn_wh_request_dtl_item.update(trn_wh_request_dtl_item_params)
        format.html { redirect_to @trn_wh_request_dtl_item, notice: 'Trn wh request dtl item was successfully updated.' }
        format.json { render :show, status: :ok, location: @trn_wh_request_dtl_item }
      else
        format.html { render :edit }
        format.json { render json: @trn_wh_request_dtl_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trn_wh_request_dtl_items/1
  # DELETE /trn_wh_request_dtl_items/1.json
  def destroy
    @trn_wh_request_dtl_item.destroy
    respond_to do |format|
      format.html { redirect_to trn_wh_request_dtl_items_url, notice: 'Trn wh request dtl item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trn_wh_request_dtl_item
      @trn_wh_request_dtl_item = TrnWhRequestDtlItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trn_wh_request_dtl_item_params
      params.fetch(:trn_wh_request_dtl_item, {})
    end
end
