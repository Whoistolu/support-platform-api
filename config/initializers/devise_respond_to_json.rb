Rails.application.config.to_prepare do
  DeviseController.respond_to :json
end
