def redis_cfg(envconfig, env)
  env = 'test' if ENV['BUILDER'] == 'true'
  config = envconfig[env]

  config.each_key do |name|
    if config[name][:password] == ""
      config[name].delete(:password)
    end

    if config[name].key?(:cluster) &&
      if config[name][:cluster].to_s.strip != ""
        config[name][:cluster] = config[name][:cluster]
                                   .strip.split(/\s/)
                                   .map { |addr| 'redis://' + addr }
      else
        config[name].delete(:cluster)
      end

      config[name].delete(:host)
      config[name].delete(:port)
      config[name].delete(:db)
    end
  end

  config
end

def load_cfg(file_name, fallback = nil)
  path = Rails.root.join("config", "#{file_name}.yml")

  if !File.exists?(path) && fallback != nil
    path = Rails.root.join("config", "#{fallback}.yml")
  end

  begin
    data = ERB.new(File.read(path)).result
    return YAML.load(data).with_indifferent_access.freeze
  rescue Exception => e
    raise("Failed to load #{file_name}.yml: #{e}")
  end
end

REDIS_CONFIG = redis_cfg(load_cfg(:redis), Rails.env)
