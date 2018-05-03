class VideoRepository < Hanami::Repository
  # Find based in user ID
  def find_by_user(id)
    aggregate(:user_id).where(id: id).map_to(Video)
  end

  # Find by
  def find_by_visible(visible)
    videos.where(visible: visible).as(Video)
  end

  # Find Video by ID (uuid)
  def find_by_id(id)
    videos.where(id: id).as(Video).one
  end

  # Exist video return true or false
  def video_exists?(id)
    find_by_id(id).nil?
  end
end
