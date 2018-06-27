class Api::UsersController < ApiController
    before_filter :authenticate_request! , except: [:authenticate]
    before_filter :set_user, only:[:show,:update,:destroy]
    before_filter :set_user_by_username, only:[:authenticate]


    def index
        @users = User.all
        respond_with @users, status: :ok
    end

    def show
#        respond_with @user, status: :ok
         render json: retorno(@use), status: :ok
    end

    def create
        @user = User.create(user_params)
        if @user.save
            render json: @user, status: :created
        else
            render json: show_error(400,@user.errors), status: :bad_request
        end
    end

    def authenticate
        authenticator = UserAuthenticator.new(@user).authenticate(password)
        if authenticator
            render json: payload(authenticator), status: :ok
        else
            render json: show_error(401, "Invalid user/password"), status: :unauthorized    
        end
    end
    
    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:email,
                                     :name,
                                     :first_last_name,
                                     :second_last_name,
                                     :birth_date,
                                     :password,
                                     :password_confirmation,
                                     :username)
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
            user: {id: user.id, user_type: user.user_type, status: user.status, username: user.username, name: user.name, first_last_name: user.first_last_name, second_last_name: user.second_last_name, email: user.email}
        }
    end

    def retorno(user)
        {
            user: {id: user.id, user_type: user.user_type, status: user.status, username: user.username, name: user.name, first_last_name: user.first_last_name, second_last_name: user.second_last_name, email: user.email}   
        }
    
end