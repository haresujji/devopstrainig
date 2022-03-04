class MstVendorsController < ApplicationController
  before_action :set_mst_vendor, only: [:show, :edit, :update, :destroy]

  # GET /mst_vendors
  # GET /mst_vendors.json
  def index
    @mst_vendors = MstVendor.all
  end

  # GET /mst_vendors/1
  # GET /mst_vendors/1.json
  def show
  end

  # GET /mst_vendors/new
  def new
    @mst_vendor = MstVendor.new
  end

  # GET /mst_vendors/1/edit
  def edit
  end

  # POST /mst_vendors
  # POST /mst_vendors.json
  def create
    @mst_vendor = MstVendor.new(mst_vendor_params)

    respond_to do |format|
      if @mst_vendor.save
        format.html { redirect_to @mst_vendor, notice: 'Mst vendor was successfully created.' }
        format.json { render :show, status: :created, location: @mst_vendor }
      else
        format.html { render :new }
        format.json { render json: @mst_vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mst_vendors/1
  # PATCH/PUT /mst_vendors/1.json
  def update
    respond_to do |format|
      if @mst_vendor.update(mst_vendor_params)
        format.html { redirect_to @mst_vendor, notice: 'Mst vendor was successfully updated.' }
        format.json { render :show, status: :ok, location: @mst_vendor }
      else
        format.html { render :edit }
        format.json { render json: @mst_vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mst_vendors/1
  # DELETE /mst_vendors/1.json
  def destroy
    @mst_vendor.destroy
    respond_to do |format|
      format.html { redirect_to mst_vendors_url, notice: 'Mst vendor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mst_vendor
      @mst_vendor = MstVendor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mst_vendor_params
      params.require(:mst_vendor).permit(:vendor_group_code, :vendor_code, :vendor_title, :vendor_firstname, :vendor_lastname, :status)
    end
end
