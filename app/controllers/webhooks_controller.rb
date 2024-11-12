class WebhooksController < ActionController::API
  def messenger
    Rails.logger.info("Expected VERIFY_TOKEN: #{ENV['FACEBOOK_VERIFY_TOKEN']}")
    if params['hub.mode'] == 'subscribe' && params['hub.verify_token'] == ENV['FACEBOOK_VERIFY_TOKEN']
      render plain: params['hub.challenge']
    else
      render plain: 'Verification token mismatch', status: :forbidden
    end
  end
end
