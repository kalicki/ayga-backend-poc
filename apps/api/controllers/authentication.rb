module Api
  module Authentication
    module Skip
      def authenticate!
      end
    end
  
    def self.included(action)
      action.class_eval do
        before :authenticate!
      end
    end
  
    private
  
    def authenticate!
      return unless current_user.nil?

      halt 401, {
        success: false,
        status_message: 'Not Authorized'
      }.to_json
    end

    def current_user
      user_id = validate_token ? validate_token['user_id'] : nil
      UserRepository.new.find_by_id(user_id)
    end

    def validate_token
      token_header = request.env['HTTP_AUTHORIZATION']
      return unless token_header
      token = token_header.split.last

      JwtService.decode(token)
    end
  end
end