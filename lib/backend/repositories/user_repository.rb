class UserRepository < Hanami::Repository
  associations do
    has_many :videos
  end

  # Find User by Email
  def find_by_email(email)
    users.where(email: email).as(User).one
  end

  # Find User by ID (uuid)
  def find_by_id(id)
    users.where(id: id).as(User).one
  end

  # Check if user exists by email
  def email_exists?(email)
    !find_by_email(email).nil?
  end

  def user_exists?(id)
    find_by_id(id).nil?
  end
end
