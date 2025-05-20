module Api
  module Users
    class RegistrationsController < Devise::RegistrationsController
      respond_to :json

      private

      def respond_with(resource, _opts = {})
        if resource.persisted?
          render json: {
            message: "Signed up successfully.",
            user: {
              id: resource.id,
              email: resource.email,
              name: resource.name,
              role: resource.role,
              created_at: resource.created_at,
              updated_at: resource.updated_at
            }
          }, status: :created
        else
          render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def sign_up_params
        params.require(:user).permit(:email, :password, :password_confirmation, :name)
      end
    end
  end
end
