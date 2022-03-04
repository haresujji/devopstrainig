class WhStockTransfersController < ApplicationController
  before_action :set_wh_stock_transfer, only: [:show, :edit, :update, :destroy]

  # GET /wh_stock_transfers
  # GET /wh_stock_transfers.json
  def index
    @wh_stock_transfers = WhStockTransfer.all
  end

  # GET /wh_stock_transfers/1
  # GET /wh_stock_transfers/1.json
  def show
  end

  # GET /wh_stock_transfers/new
  def new
    @wh_stock_transfer = WhStockTransfer.new
  end

  # GET /wh_stock_transfers/1/edit
  def edit
  end

  # POST /wh_stock_transfers
  # POST /wh_stock_transfers.json
  def create
    @wh_stock_transfer = WhStockTransfer.new(wh_stock_transfer_params)

    respond_to do |format|
      if @wh_stock_transfer.save
        format.html { redirect_to @wh_stock_transfer, notice: 'Wh stock transfer was successfully created.' }
        format.json { render :show, status: :created, location: @wh_stock_transfer }
      else
        format.html { render :new }
        format.json { render json: @wh_stock_transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wh_stock_transfers/1
  # PATCH/PUT /wh_stock_transfers/1.json
  def update
    respond_to do |format|
      if @wh_stock_transfer.update(wh_stock_transfer_params)
        format.html { redirect_to @wh_stock_transfer, notice: 'Wh stock transfer was successfully updated.' }
        format.json { render :show, status: :ok, location: @wh_stock_transfer }
      else
        format.html { render :edit }
        format.json { render json: @wh_stock_transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wh_stock_transfers/1
  # DELETE /wh_stock_transfers/1.json
  def destroy
    @wh_stock_transfer.destroy
    respond_to do |format|
      format.html { redirect_to wh_stock_transfers_url, notice: 'Wh stock transfer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wh_stock_transfer
      @wh_stock_transfer = WhStockTransfer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wh_stock_transfer_params
      params.require(:wh_stock_transfer).permit(:document_no, :truck_no, :po_number, :received_qty, :mat_code, :mat_desc, :gross_weight, :tare_weight, :net_weight)
    end
end
