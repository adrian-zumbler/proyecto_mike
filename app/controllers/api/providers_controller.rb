class Api::ProvidersController < ApiController
    
        before_filter :set_provider, only:[:show,:update,:destroy]
    
    
        def index
            @providers = Provider.all
            respond_with @providers, status: :ok
        end
    
        def show
            respond_with @provider, status: :ok
        end
    
        def create
            @provider = Provider.new(provider_params)
            if @provider.save
                render json: @provider, status: :created
            else
                render :json => { :errors => @provider.errors.full_messages }, status: :bad_request    
            end
        end
    
        def update
            if @provider.update(provider_params)
                render json: @provider, status: :created
            else
                render :json => { :errors => @provider.errors.full_messages }, status: :bad_request    
            end
        end
    
        private
    
        def set_provider
            @provider = Provider.find(params[:id])
        end
    
        def provider_params
            params.require(:provider).permit(:name,:person,:first_last_name,:second_last_name,:birth_date,
                :street,:distrit,:postal_code,:state,:city,:rfc)
        end
    
    end