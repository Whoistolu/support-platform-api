
module Api
    module Users
        class ConfirmationsController < Devise::ConfirmationsController
            respond_to :json

            def show
                self.resource = resource_class.confirm_by_token(params[:confirmation_token])
                if resource.errors.empty?
                render json: { message: "Email confirmed successfully." }
                else
                render json: { error: resource.errors.full_messages }, status: :unprocessable_entity
                end
            end
        end
    end
end
