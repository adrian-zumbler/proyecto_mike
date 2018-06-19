class UserAuthenticator

    ERROR_AUTHENTICATE = "Invalido usario  y/o passoword"
    
    def initialize(user)
        @user = user
        @login_successfull = false
        @errors = Set.new
    end

    def authenticate(unencrypted_password)
        return false unless @user
        if @user.valid_password? unencrypted_password
            @login_successfull = true
            @user
        else
            @errors << ERROR_AUTHENTICATE
            false
        end
    end

    def errors
        @errors
    end
end
