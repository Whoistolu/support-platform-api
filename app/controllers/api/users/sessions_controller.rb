module Api
  module Users
    class SessionsController < Devise::SessionsController
      respond_to :json

      def create
        user = User.find_for_database_authentication(email: sign_in_params[:email])

        if user&.valid_password?(sign_in_params[:password])

          payload = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil)
          token = payload[0]

          render json: {
            message: "Logged in successfully.",
            token: token,
            user: {
              id: user.id,
              email: user.email,
              name: user.name,
              role: user.role,
              created_at: user.created_at,
              updated_at: user.updated_at
            }
          }, status: :ok
        else
          render json: { error: "Invalid email or password" }, status: :unauthorized
        end
      end


      private

      def sign_in_params
        params.require(:user).permit(:email, :password)
      end

      def respond_to_on_destroy
        if current_user
          render json: { message: "Logged out successfully." }, status: :ok
        else
          render json: { message: "User has no active session." }, status: :unauthorized
        end
      end
    end
  end
end
