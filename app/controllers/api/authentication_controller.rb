module Api
  class AuthenticationController < ApplicationController
    before_action: authorize_request, except: :login
    
    #Post /auth/login
    def login
      @user = User.find_by_email(params[:email])
      if @user&.authenticate(params[:password])
        time = Time.now + 24.hours.to_i
        token = JsonWebToken.encode({user_id: @user.id}, time)
        render json: {
          token: token,
          exp: time.strftime("%m-%d-%Y %H:%M"),
          name: @user.name,
          handle: @user.handle,
          email: @user.email
          }, status: :ok
        else
          render json: { error: 'unauthorized' }, status: :unauthorized
        end
      end
      
    private
      def login_params
        params.permit(:email, :password)
      end
  end
end
  
  