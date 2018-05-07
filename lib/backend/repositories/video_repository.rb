class VideoRepository < Hanami::Repository
  def show_videos
    find_by_visible(true)
  end

  # Find based in user ID
  def find_by_user(id)
    aggregate(:user_id).where(id: id).map_to(Video)
  end

  # Find by visible`s
  def find_by_visible(visible)
    videos.where(visible: visible).as(Video)
  end

  # Find Video by ID (uuid)
  def find_by_id(id)
    videos.where(id: id).as(Video).one
  end

  # Exists video then return true else false
  def video_exists?(id)
    find_by_id(id).nil?
  end

  # Search global
  def search(value)
    return if value.nil?

    text = pattern(value)
    videos.where { visible.is(true) & title.ilike(text) | description.ilike(text) | array_to_string(tags, ',').ilike(text) }.as(Video)
  end

  private

  def pattern(text)
    "%#{text.downcase}%"
  end

  # Search by title and description
  def search_text(query, text)
    text = pattern(text)
    query.where { title.ilike(text) | description.ilike(text) }
  end

  # Search by tags
  def search_tags(query, tags)
    Array(tags).each do |tag|
      tag = pattern(tag)
      query.where { array_to_string(tags, ',').ilike(tag) }
    end
    query
  end
end
