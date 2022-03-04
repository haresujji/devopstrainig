class Api::TrnWhTransportDtlsController < Api::ApiController
  before_action :authenticate_user
  before_action :set_trn_wh_transport_dtl, only: [:show, :edit, :update, :destroy]

  # GET /trn_wh_transport_dtls/new
  def new
    @trn_wh_transport_dtl = TrnWhTransportDtl.new
  end

  # POST /trn_wh_transport_dtls
  # POST /trn_wh_transport_dtls.json
  def create
    begin
      trn_wh_transport_dtl = TrnWhTransportDtl.find_by(prq_docno: params[:prq_docno])
        if trn_wh_transport_dtl
          trn_wh_transport_dtl.update_attributes(trn_wh_transport_dtl_params)
          render json: trn_wh_transport_dtl, status: :ok
       else
          @trn_wh_transport_dtl = TrnWhTransportDtl.new(trn_wh_transport_dtl_params)
          @trn_wh_transport_dtl.save
          render json: @trn_wh_transport_dtl, status: :created
       end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def fetch_transport_dtls
    begin
      lists = TrnWhTransportDtl.select('distinct prq_docno,transport_name,driver_name,delievery_dt,driver_phone,truck_number,driver_licence,bill_no')
        if lists.blank?
          render json: {status:"error", "message": "No Datas Found"}, status: :internal_server_error 
        else
          render json:lists
        end 
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trn_wh_transport_dtl
      @trn_wh_transport_dtl = TrnWhTransportDtl.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trn_wh_transport_dtl_params
      trn_wh_transport_dtl_params = params.require(:trn_wh_transport_dtl)
                                    .permit( :prq_docno,:transport_name,:driver_name,:delievery_dt,:driver_phone,:truck_number,:driver_licence,:bill_no)
    end
end
