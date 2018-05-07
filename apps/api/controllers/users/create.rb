module Api::Controllers::Users
  class Create
    include Api::Action
    include Api::Authentication::Skip

    params do
      required(:first_name).filled(:str?)
      required(:last_name).filled(:str?)
      required(:email).filled(:str?, format?: FormatsRegex.email)
      required(:encrypted_password).filled(:str?, min_size?: 8).confirmation
    end

    def call(params)
      # Error based in params
      unless params.valid?
        self.status = 422
        return self.body = {
          success: false,
          status_message: params.errors
        }.to_json
      end

      # Create object User
      repository = UserRepository.new

      # Check user exists via email
      if repository.email_exists?(params[:email])
        self.status = 422
        return self.body = {
          success: false,
          status_message: 'User exists'
        }.to_json
      end

      # Create new user
      user = repository.create(
        first_name: params[:first_name],
        last_name: params[:last_name],
        email: params[:email],
        encrypted_password: Argon2::Password.create(params[:encrypted_password])
      )
      self.status = 201
      self.body = {
        success: true,
        status_message: 'Added user',
        data: user.infos
      }.to_json
    end
  end
end