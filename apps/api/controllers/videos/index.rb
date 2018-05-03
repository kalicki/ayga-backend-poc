module Api::Controllers::Videos
  class Index
    include Api::Action
    include Hanami::Pagination::Action

    def call(params)
      # Initialize video
      repo = VideoRepository.new

      self.status = 200
      self.body = {
        success: true,
        status_message: 'Show all video',
        data: all_for_page(repo.videos)
      }.to_json
    end

    # Set limit itens per page for pagination
    def limit
      10
    end
  end
end
