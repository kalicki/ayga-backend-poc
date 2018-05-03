class User < Hanami::Entity
  # Return infos user remove password
  def infos
    to_h.tap do |attributes|
      attributes.delete(:encrypted_password)
    end
  end

  # Return true or false based if is admin
  def admin?
    admin
  end

  # Valid password
  def valid_password?(password)
    Argon2::Password.verify_password(password, encrypted_password)
  end
end
