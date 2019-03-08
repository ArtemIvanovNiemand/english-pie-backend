module APIHelpers
  extend Grape::API::Helpers

  def success(message:, data: {})
    status 200

    {
        message: message,
        data: data
    }
  end

  def bad_request!(message)
    custom_error!(message, 400)
  end

  def not_found!
    custom_error!(I18n.t("api.error_404"),404)
  end

  def unauthorized!(message = I18n.t("api.error_401"))
    custom_error!(message,401)
  end

  def server_error!
    custom_error!(I18n.t("api.error_500"),500)
  end

  private

  def custom_error!(message, code = 500)
    error!(
        {
            message: message,
            data: {}
        },
        code
    )
  end
end
