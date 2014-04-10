module Parapets
  module Controller
    class API < ActionController::Metal
      abstract!

      include ActionController::UrlFor
      include ActionController::Redirecting
      include ActionController::ConditionalGet
      include ActionController::DataStreaming
      include ActionController::StrongParameters

    end
  end
end
