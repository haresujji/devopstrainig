class WhBundleTypesController < ApplicationController
  before_action :set_wh_bundle_type, only: [:show, :update, :destroy]

  # GET /wh_bundle_types
  # GET /wh_bundle_types.json
  def index
    @wh_bundle_types = WhBundleType.all
  end

  # GET /wh_bundle_types/1
  # GET /wh_bundle_types/1.json
  def show
  end

  # POST /wh_bundle_types
  # POST /wh_bundle_types.json
  def create
    @wh_bundle_type = WhBundleType.new(wh_bundle_type_params)

    if @wh_bundle_type.save
      render :show, status: :created, location: @wh_bundle_type
    else
      render json: @wh_bundle_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /wh_bundle_types/1
  # PATCH/PUT /wh_bundle_types/1.json
  def update
    if @wh_bundle_type.update(wh_bundle_type_params)
      render :show, status: :ok, location: @wh_bundle_type
    else
      render json: @wh_bundle_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /wh_bundle_types/1
  # DELETE /wh_bundle_types/1.json
  def destroy
    @wh_bundle_type.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wh_bundle_type
      @wh_bundle_type = WhBundleType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wh_bundle_type_params
      params.fetch(:wh_bundle_type, {})
    end
end
