class TrtMstsController < ApplicationController
  before_action :set_trt_mst, only: [:show, :edit, :update, :destroy]

  # GET /trt_msts
  # GET /trt_msts.json
  def index
    @trt_msts = TrtMst.all
  end

  # GET /trt_msts/1
  # GET /trt_msts/1.json
  def show
  end

  # GET /trt_msts/new
  def new
    @trt_mst = TrtMst.new
  end

  # GET /trt_msts/1/edit
  def edit
  end

  # POST /trt_msts
  # POST /trt_msts.json
  def create
    @trt_mst = TrtMst.new(trt_mst_params)

    respond_to do |format|
      if @trt_mst.save
        format.html { redirect_to @trt_mst, notice: 'Trt mst was successfully created.' }
        format.json { render :show, status: :created, location: @trt_mst }
      else
        format.html { render :new }
        format.json { render json: @trt_mst.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trt_msts/1
  # PATCH/PUT /trt_msts/1.json
  def update
    respond_to do |format|
      if @trt_mst.update(trt_mst_params)
        format.html { redirect_to @trt_mst, notice: 'Trt mst was successfully updated.' }
        format.json { render :show, status: :ok, location: @trt_mst }
      else
        format.html { render :edit }
        format.json { render json: @trt_mst.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trt_msts/1
  # DELETE /trt_msts/1.json
  def destroy
    @trt_mst.destroy
    respond_to do |format|
      format.html { redirect_to trt_msts_url, notice: 'Trt mst was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trt_mst
      @trt_mst = TrtMst.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trt_mst_params
      params.fetch(:trt_mst, {})
    end
end
