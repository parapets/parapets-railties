module Parapets
  module Railties
    module Routing


      class RouteSet < ActionDispatch::Routing::RouteSet

        private
          def default_scope
            scope = {action: Parapets::Service::Controller::ACTION, format: false}

            scope
          end

          # Redefine this method to change the mapper class
          def eval_block(block)
            mapper = Mapper.new(self)
            mapper.with_default_scope(default_scope, &block)
          end
      end


    end
  end
end

