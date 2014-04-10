require 'rails/application'
require 'rails/application/default_middleware_stack'

module Parapets
  module Railties
    module Application

      def routes
        @routes ||= route_set_class.new
        @routes.append(&Proc.new) if block_given?
        @routes
      end

      protected
        def default_middleware_stack
          builder = default_middleware_stack_builder_class.new(self, config, paths)
          builder.build_stack
        end

        def default_middleware_stack_builder_class
          Rails::Application::DefaultMiddlewareStack
        end

        def route_set_class
          ActionDispatch::Routing::RouteSet
        end
    end

    class << self

      # This function returns a subclass of Rails::Application with some 
      # hooks to customize it's defaults
      def Application(&block)
        Class.new(Rails::Application) do
          include Parapets::Railties::Application

          instance_eval(&block)
        end
      end

    end
  end

  class << self
    delegate :application, :root, :env, to: Rails
  end
end
