class Api::ClientsController < ApiController

    before_filter :set_client, only:[:show,:update,:destroy]


    def index
        @clients = Client.all
        respond_with @clients, status: :ok
    end

    def show
        respond_with @client, status: :ok
    end

    def create
        @client = Client.new(client_params)
        if @client.save
            render json: @client, status: :created
        else
            render :json => { :errors => @client.errors.full_messages }, status: :bad_request    
        end
    end

    def update
        if @client.update(client_params)
            render json: @client, status: :created
        else
            render :json => { :errors => @client.errors.full_messages }, status: :bad_request    
        end
    end

    private

    def set_client
        @client = Client.find(params[:id])
    end

    def client_params
        params.require(:client).permit(:name,:person,:first_last_name,:second_last_name,:birth_date,
            :street,:distrit,:postal_code,:state,:city,:rfc)
    end

end