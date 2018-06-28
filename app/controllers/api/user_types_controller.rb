class Api::User_typesController < ApiController

    before_filter :authenticate_request!
    before_filter :set_user_type, only:[:show,:update,:destroy]


    def index
        @user_types = user_type.all
        respond_with @user_types, status: :ok
    end

    def show
        respond_with @user_type, status: :ok
    end

    
    def user_type_params
        params.require(:user_type).permit(:description)
    end
    
    private

    def set_user_type
        @user_type = user_type.find(params[:id])
    end
end