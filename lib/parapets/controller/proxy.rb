module Parapets
  module Controller
    class Proxy < ActionController::Metal
      abstract!

      def perform
      end

      class << self
        # Defines the endpoint to which the proxy controller will forward the request
        def endpoint(endpoint=nil)
          @endpoint = endpoint if endpoint
          @endpoint
        end
      end
    end
  end
end
