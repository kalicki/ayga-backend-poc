module Api::Controllers::Videos
  class Create
    include Api::Action

    params do
      required(:user_id).filled(:str?, format?: FormatsRegex.uuid)
      required(:title).filled(:str?)
      required(:description).filled(:str?)
      required(:thumbnail).filled(:str?)
      required(:url_video).filled(:str?)
      required(:tags).each(:str?)
      required(:visible).filled(:bool?)
    end

    def call(params)
      # Error based in params
      unless params.valid?
        self.status = 422
        return self.body = {
          success: false,
          status_message: params.errors.to_hash
        }.to_json
      end

      # Create object user for check if is admin
      user = UserRepository.new.find_by_id(params[:user_id])
      unless user.admin?
        self.status = 401
        return self.body = {
          success: false,
          status_message: 'Dont have permission'
        }.to_json
      end

      # Create object Video
      repository = VideoRepository.new
      # Create new video
      video = repository.create(params)

      self.status = 201
      self.body = {
        success: true,
        status_message: 'Added video',
        data: video.to_hash
      }.to_json
    end
  end
end
