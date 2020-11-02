if Rails.env.production?
  uri = URI.parse(ENV["REDIS_URL"])
  REDIS_INSTANCE = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
else
  REDIS_INSTANCE = Redis.new
end
