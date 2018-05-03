module Api::Controllers::Users
  class Destroy
    include Api::Action

    params do
      required(:id).filled(:str?, format?: FormatsRegex.uuid)
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

      # Initiazlize object User
      repository = UserRepository.new

      # Check user exists by id
      if repository.user_exists?(params[:id])
        self.status = 404
        return self.body = {
          success: false,
          status_message: 'User do not exists'
        }.to_json
      end

      # Remove user
      repository.delete(params[:id])
      self.status = 200
      self.body = {
        success: true,
        status_message: 'User removed'
      }.to_json
    end
  end
end