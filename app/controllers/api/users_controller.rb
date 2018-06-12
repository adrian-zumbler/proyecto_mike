class Api::UsersController < ApiController
    
    before_filter :set_user, only:[:show,:update,:destroy]
    before_filter :set_user_by_username, only:[:authenticate]


    def index
        @users = User.all
        respond_with @users, status: :ok
    end

    def show
        respond_with @user, status: :ok
    end

    def create
        @user = User.create(user_params)
        if @user.save
            render json: @user, status: :created
        else
            render json: {
                message: @user.errors
            }, status: :bad_request
        end
    end

    def authenticate
        authenticator = UserAuthenticator.new(@user).authenticate(password)
        if authenticator
            render json: payload(authenticator), status: :ok
        else
            render json: authenticator.errors, status: :unauthorized    
        end
    end
    
    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:email,:name,:first_last_name,:second_last_name,:birth_date,:password,:password_confirmation,:username)
    end

    def authenticate_params
        params.require(:user).permit(:username,:password)
    end

    def username
        authenticate_params[:username]
    end

    def password
        authenticate_params[:password]
    end

    def set_user_by_username
        @user = User.find_for_database_authentication(username: username)
    end

    def payload(user)
        {
            token: JsonWebToken.encode({user_id: user.id}),
            user: {id: user.id, email: user.username}
        }
    end
    
end