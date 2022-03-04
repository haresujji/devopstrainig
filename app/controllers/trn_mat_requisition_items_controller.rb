class TrnMatRequisitionItemsController < ApplicationController
  before_action :set_trn_mat_requisition_item, only: [:show, :edit, :update, :destroy]

  # GET /trn_mat_requisition_items
  # GET /trn_mat_requisition_items.json
  def index
    @trn_mat_requisition_items = TrnMatRequisitionItem.all
  end

  # GET /trn_mat_requisition_items/1
  # GET /trn_mat_requisition_items/1.json
  def show
  end

  # GET /trn_mat_requisition_items/new
  def new
    @trn_mat_requisition_item = TrnMatRequisitionItem.new
  end

  # GET /trn_mat_requisition_items/1/edit
  def edit
  end

  # POST /trn_mat_requisition_items
  # POST /trn_mat_requisition_items.json
  def create
    @trn_mat_requisition_item = TrnMatRequisitionItem.new(trn_mat_requisition_item_params)

    respond_to do |format|
      if @trn_mat_requisition_item.save
        format.html { redirect_to @trn_mat_requisition_item, notice: 'Trn mat requisition item was successfully created.' }
        format.json { render :show, status: :created, location: @trn_mat_requisition_item }
      else
        format.html { render :new }
        format.json { render json: @trn_mat_requisition_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trn_mat_requisition_items/1
  # PATCH/PUT /trn_mat_requisition_items/1.json
  def update
    respond_to do |format|
      if @trn_mat_requisition_item.update(trn_mat_requisition_item_params)
        format.html { redirect_to @trn_mat_requisition_item, notice: 'Trn mat requisition item was successfully updated.' }
        format.json { render :show, status: :ok, location: @trn_mat_requisition_item }
      else
        format.html { render :edit }
        format.json { render json: @trn_mat_requisition_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trn_mat_requisition_items/1
  # DELETE /trn_mat_requisition_items/1.json
  def destroy
    @trn_mat_requisition_item.destroy
    respond_to do |format|
      format.html { redirect_to trn_mat_requisition_items_url, notice: 'Trn mat requisition item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trn_mat_requisition_item
      @trn_mat_requisition_item = TrnMatRequisitionItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trn_mat_requisition_item_params
      params.require(:trn_mat_requisition_item).permit(:req_no, :mat_code, :mat_desc, :mat_uom, :mat_qty)
    end
end
