module Api
  module CorsHeaders
    def self.included(action)
      action.class_eval do
        before :include_cors_headers
      end
    end

    def include_cors_headers
      headers.merge!(cors_headers)
    end

    private

    def cors_headers
      {
        'Access-Control-Allow-Origin' => Settings::Cors::CORS_ALLOW_ORIGIN,
        'Access-Control-Allow-Methods' => Settings::Cors::CORS_ALLOW_METHODS,
        'Access-Control-Allow-Headers' => Settings::Cors::CORS_ALLOW_HEADERS
      }
    end
  end
end