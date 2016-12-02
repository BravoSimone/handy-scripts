module Clients
  class Float
    BASE_URL = "https://api.float.com/api/v1"
    AVALIABLE_CALLS = %w(people projects tasks holiday)
    attr_writer   :secret

    def initialize(secret)
      @secret = secret
    end

    def method_missing(method_name, *params)
      return super unless respond_to?(method_name)
      uri = generate_uri(method_name.to_s, params.first)
      HTTP.auth("Bearer #{@secret}").get(uri).body.to_s
    end

    def respond_to_missing?(method_name, include_private = false)
      AVALIABLE_CALLS.include?(method_name.to_s) || super
    end

    private

    def generate_uri(resource, params)
      params ||= {}
      uri = URI("#{BASE_URL}/#{resource}?#{params.to_query}")
    end
  end
end
