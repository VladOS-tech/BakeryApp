class JwtService
  SECRET = Rails.application.credentials.jwt_secret || ENV["JWT_SECRET"] || "devsecret"

  def self.encode(payload, exp = 7.days.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET)
  end

  def self.decode(token)
    body = JWT.decode(token, SECRET)[0]
    HashWithIndifferentAccess.new(body)
  rescue
    nil
  end
end
