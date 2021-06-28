if Rails.env.production?
  uri = URI.parse(ENV["REDIS_URL"])
  REDIS_INSTANCE = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }, driver: :ruby)
else
  REDIS_INSTANCE = Redis.new
end
