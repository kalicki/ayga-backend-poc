module Api::Controllers::Videos
  class Destroy
    include Api::Action

    params do
      required(:id).filled(:str?, format?: FormatsRegex.uuid)
    end

    def call(params)
      # Error based in params
      unless params.valid?
        halt 422, {
          success: false,
          status_message: params.errors
        }.to_json
      end

      # Initiazlize object videos
      repository = VideoRepository.new

      # Check user exists by id
      if repository.video_exists?(params[:id])
        halt 404, {
          success: false,
          status_message: 'Video do not exists'
        }.to_json
      end

      # Remove user
      repository.delete(params[:id])
      status 200, {
        success: true,
        status_message: 'Video removed'
      }.to_json
    end
  end
end