class Api::UserTypesController < ApiController

    before_filter :authenticate_request!
    before_filter :set_user_type, only:[:show]


    def index
        @user_types = UserType.all
        respond_with @user_types, status: :ok
    end

    def show
        respond_with @user_type, status: :ok
    end

    private

    def set_user_type
        @user_type = UserType.find(params[:id])
    end
end