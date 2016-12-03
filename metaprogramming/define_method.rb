# In this module we're creating a kind of object oriented API, to do that we're using define_method taking method names
# from an array. In this case I took the method's list from the floatsheduler's github page. If one day they will add
# another resource most of the times I will only need to add another string in my AVALIABLE_CALLS array
module Clients
  class Float
    BASE_URL = "https://api.float.com/api/v1"
    AVALIABLE_CALLS = %w(people projects tasks holiday)
    attr_writer   :secret

    def initialize(secret)
      @secret = secret
    end

    AVALIABLE_CALLS.each do |method_name|
      define_method method_name do |*params|
        uri = generate_uri(method_name.to_s, params.first)
        p uri
        HTTP.auth("Bearer #{@secret}").get(uri).body.to_s
      end
    end

    private

    def generate_uri(resource, params)
      params ||= {}
      uri = URI("#{BASE_URL}/#{resource}?#{params.to_query}")
    end
  end
end
