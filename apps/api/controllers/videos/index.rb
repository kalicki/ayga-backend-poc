module Api::Controllers::Videos
  class Index
    include Api::Action
    include Hanami::Pagination::Action

    def call(params)
      # Initialize video
      repo = VideoRepository.new
      videos = all_for_page(repo.show_videos)

      status 200, {
        success: true,
        status_message: 'Show all video',
        data: wrap(videos),
        pagination: {
          next_page: pager.next_page,
          prev_page: pager.prev_page,
          current_page: pager.current_page,
          all_pages: pager.all_pages,
          total_pages: pager.total_pages,
          total: pager.total
        }
      }.to_json
    end

    # Set limit itens per page for pagination
    # ref: https://github.com/davydovanton/hanami-pagination/blob/master/lib/hanami/pagination/action.rb#L16
    def limit
      10
    end

    private

    def wrap(collection)
      collection.map(&:to_h)
    end
  end
end
