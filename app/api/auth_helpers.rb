module AuthHelpers
  extend Grape::API::Helpers

  def current_user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token

    @user
  end

  def authorized?
    current_user.present?
  end

  def admin?
    current_user&.access_level == 'admin'
  end

  private

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    request.headers['Authorization']
  end
end
