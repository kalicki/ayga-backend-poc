module Api::Controllers::Videos
  class Create
    include Api::Action

    params do
      # required(:user_id).filled(:str?, format?: FormatsRegex.uuid)
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
        halt 422, {
          success: false,
          status_message: params.errors.to_hash
        }.to_json
      end

      # Create object user for check if is admin
      user = current_user
      unless user && user.admin?
        halt 401, {
          success: false,
          status_message: 'Dont have permission for add video'
        }.to_json
      end

      # Object Video
      repository = VideoRepository.new
      # Create persistence video
      video = repository.create(
        user_id: user.id,
        title: params[:title],
        description: params[:description],
        thumbnail: params[:thumbnail],
        url_video: params[:url_video],
        tags: params[:tags],
        visible: params[:visible]
      )

      # Return object JSON
      status 201, {
        success: true,
        status_message: 'Added video',
        data: video.to_hash
      }.to_json
    end
  end
end
