module Parapets
  class Request < ActionDispatch::Request
    def request_version
      match = /version=(?<version>\d+)/.match(env['HTTP_ACCEPT'])

      match[:version] && match[:version].to_i
    end
  end
end
