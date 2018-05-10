module Api::Controllers::Videos
  class Show
    include Api::Action

    params do
      required(:id).filled(:str?, format?: FormatsRegex.uuid)
    end

    def call(params)
      # Error based in params
      unless params.valid?
        halt 422, {
          success: false,
          status_message: params.errors.to_hash
        }.to_json
      end

      # Object Video
      repository = VideoRepository.new

      # Return object JSON
      status 201, {
        success: true,
        status_message: 'Show video',
        data: repository.find_by_id(params[:id]).to_hash
      }.to_json
    end
  end
end
