class JwtService
  DEFAULT_EXPIRE_TIME = 24 * 3600 # 24 hours

  def self.encode(user_id, exp = Time.now.to_i + DEFAULT_EXPIRE_TIME)
    payload = {
      user_id: user_id,
      iss: ENV['API_HOST'],
      exp: exp
    }
    token = JWT.encode(payload, ENV['JWT_SECRET'], 'HS256')
    { auth_token: token }
  end

  def self.decode(token)
    begin
      JWT.decode(token, ENV['JWT_SECRET'], true, iss: ENV['API_HOST'], algorithm: 'HS256')[0]
    rescue JWT::DecodeError
      nil
    end
  end
end