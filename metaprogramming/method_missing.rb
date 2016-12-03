# In this module we're creating a kind of object oriented API, to do that we're using method_missing and
# respond_to_missing? taking method names from an array. In this case I took the method's list from the floatsheduler's
# github page. If one day they will add another resource most of the times I will only need to add another string in my
# AVALIABLE_CALLS array. This example is a little trickier because instead of defining all methods on the class
# instance we take the method name and if it's present in our AVALIABLE_CALLS array we put that in the request uri,
# otherwise we return the super class and make it handle the call
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
