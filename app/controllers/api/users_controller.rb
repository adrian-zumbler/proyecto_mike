class Api::UsersController < ApiController
    
        before_filter :set_user, only:[:show,:update,:destroy]
    
    
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
        
        private
    
        def set_user
            @user = User.find(params[:id])
        end
    
        def user_params
            params.require(:user).permit(:email,:name,:first_last_name,:second_last_name,:birth_date,:password,:password_confirmation)
        end
    
    end