module Api::Controllers::Videos
  class Update
    include Api::Action

    params do
      required(:id).filled(:str?, format?: FormatsRegex.uuid)
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
          status_message: 'Dont have permission for update video'
        }.to_json
      end

      # Object Video
      repository = VideoRepository.new
      video = repository.find_by_id(params[:id])

      # User dont found
      unless video
        halt 404, {
          success: false,
          status_message: 'User dont found'
        }.to_json
      end

      # Create persistence video
      video_info = repository.update(
        video.id,
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
        status_message: 'Updated video',
        data: video_info.to_hash
      }.to_json
    end
  end
end
