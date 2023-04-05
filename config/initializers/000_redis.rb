require 'connection_pool'

def init_redis(name, config, wrapper = true)
  pool_size = ENV['REDIS_POOL_SIZE'].to_i
  pool_size = 30 if pool_size < 30

  pool_config = { size: pool_size, timeout: 1.5 }
  redis_args = config.merge(
    timeout: 2,
    )

  begin
    if wrapper
      ConnectionPool::Wrapper.new(pool_config) { Redis.new(redis_args) }
    else
      ConnectionPool.new(pool_config) { Redis.new(redis_args) }
    end
  rescue Exception => exc
    raise "Failed to init redis #{name}: #{exc.to_s}"
  end
end


def init_redis_struct(reader = false)
  struct = OpenStruct.new

  [:static, :cache].each do |redis|
    config = REDIS_CONFIG[redis].dup
    if reader && config[:cluster]
      config[:replica] = true
    end
    struct[redis] = init_redis(redis, config, false)
  end

  struct
end

# New constant holding redis connection pools, without wrapper.
# Use this where possible
REDIS ||= init_redis_struct(false).freeze

undef init_redis_struct
