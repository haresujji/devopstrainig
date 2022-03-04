class Api::WhBundleTypesController < Api::ApiController
 before_action :authenticate_user
 def bundle_list
    begin
      bundles = WhBundleType.all
        if bundles.blank?
          render json: {status:"error", "message": "No Records Found"}, status: :internal_server_error 
        else
          render json:bundles
        end      
    rescue StandardError => e
        render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end
end
  