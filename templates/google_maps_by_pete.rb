module GoogleMapsByPete
  include ActiveSupport::Concern
  
  def set_location    
    if defined? params[:model] == "constant"
       model = params[:model].capitalize
       model_id = params[:model_id]
       object = eval("#{model}.find(#{model_id})")
       object.lat = params[:lat]
       object.lng = params[:lng]
       object.save
       render json: object
    end
  end
  
end
