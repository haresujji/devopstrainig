class WhMaterialStoragesController < ApplicationController
  before_action :set_wh_material_storage, only: [:show, :edit, :update, :destroy]

  # GET /wh_material_storages
  # GET /wh_material_storages.json
  def index
    @wh_material_storages = WhMaterialStorage.all
  end

  # GET /wh_material_storages/1
  # GET /wh_material_storages/1.json
  def show
  end

  # GET /wh_material_storages/new
  def new
    @wh_material_storage = WhMaterialStorage.new
  end

  # GET /wh_material_storages/1/edit
  def edit
  end

  # POST /wh_material_storages
  # POST /wh_material_storages.json
  def create
    @wh_material_storage = WhMaterialStorage.new(wh_material_storage_params)

    respond_to do |format|
      if @wh_material_storage.save
        format.html { redirect_to @wh_material_storage, notice: 'Wh material storage was successfully created.' }
        format.json { render :show, status: :created, location: @wh_material_storage }
      else
        format.html { render :new }
        format.json { render json: @wh_material_storage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wh_material_storages/1
  # PATCH/PUT /wh_material_storages/1.json
  def update
    respond_to do |format|
      if @wh_material_storage.update(wh_material_storage_params)
        format.html { redirect_to @wh_material_storage, notice: 'Wh material storage was successfully updated.' }
        format.json { render :show, status: :ok, location: @wh_material_storage }
      else
        format.html { render :edit }
        format.json { render json: @wh_material_storage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wh_material_storages/1
  # DELETE /wh_material_storages/1.json
  def destroy
    @wh_material_storage.destroy
    respond_to do |format|
      format.html { redirect_to wh_material_storages_url, notice: 'Wh material storage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wh_material_storage
      @wh_material_storage = WhMaterialStorage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wh_material_storage_params
      params.require(:wh_material_storage).permit(:ge_doc_no,:plant,:str_loc,:mat_group,:mat_code, :mat_desc, :mat_uom,:grn_no, :grn_qty, :grn_date, 
        :vendor_batch,:mfg_date, :expiry_dt, :wh_loc_id, :wh_loc_rfid, :wh_loc_qty, :wh_picked_qty,   :wh_balance_qty, :wh_hold_reason, :sup_roll_ref,:vendor_code,:vendor_name, :sap_batch, :sap_status,:stock_status, :status,:action_status)

    end
end
