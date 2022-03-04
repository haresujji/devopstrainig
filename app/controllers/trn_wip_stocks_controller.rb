class TrnWipStocksController < ApplicationController
  before_action :set_trn_wip_stock, only: [:show, :update, :destroy]

  # GET /trn_wip_stocks
  # GET /trn_wip_stocks.json
  def index
    @trn_wip_stocks = TrnWipStock.all
  end

  # GET /trn_wip_stocks/1
  # GET /trn_wip_stocks/1.json
  def show
  end

  # POST /trn_wip_stocks
  # POST /trn_wip_stocks.json
  def create
    @trn_wip_stock = TrnWipStock.new(trn_wip_stock_params)

    if @trn_wip_stock.save
      render :show, status: :created, location: @trn_wip_stock
    else
      render json: @trn_wip_stock.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /trn_wip_stocks/1
  # PATCH/PUT /trn_wip_stocks/1.json
  def update
    if @trn_wip_stock.update(trn_wip_stock_params)
      render :show, status: :ok, location: @trn_wip_stock
    else
      render json: @trn_wip_stock.errors, status: :unprocessable_entity
    end
  end

  # DELETE /trn_wip_stocks/1
  # DELETE /trn_wip_stocks/1.json
  def destroy
    @trn_wip_stock.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trn_wip_stock
      @trn_wip_stock = TrnWipStock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trn_wip_stock_params
      params.fetch(:trn_wip_stock, {})
    end
end
