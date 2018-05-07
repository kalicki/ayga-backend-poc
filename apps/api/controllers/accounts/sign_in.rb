module Api::Controllers::Accounts
  class SignIn
    include Api::Action
    include Api::Authentication::Skip

    params do
      required(:email).filled(:str?, format?: FormatsRegex.email)
      required(:password).filled(:str?, min_size?: 8)
    end

    def call(params)
      # Error based in params
      unless params.valid?
        halt 422, {
          success: false,
          status_message: params.errors
        }.to_json
      end

      # Initialize user based in email
      user = UserRepository.new.find_by_email(params[:email])

      # Check if user exists and if password is valid
      unless user && user.valid_password?(params[:password])
        halt 401, {
          success: false,
          status_message: 'Authentication Failed'
        }.to_json
      end

      # Decode JWT
      token = JwtService.encode(user.id)
      status 201, {
        success: true,
        status_message: 'Authentication OK',
        data: token
      }.to_json
    end
  end
end
