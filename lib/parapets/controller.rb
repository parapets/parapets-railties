module Parapets
  module Controller
    extend ActiveSupport::Concern
    DEFAULT_ACTION = :perform

    included do
      include Parapets::Versionable
    end

    module ClassMethods
      def controller_class(klass=nil)
        if klass
          @controller_class = klass
        end

        @controller_class || ApplicationController
      end

      # Hack to get this class to return a Rack endpoint to the Rails router
      def action(*args)
        self
      end

      # Dispatch the Rack request to the actual controller
      def call(env)
        request = Parapets::Service::Request.new(env)
        version(request.version).action( DEFAULT_ACTION , Parapets::Request).call(env)
      end

      def build_version(version_id,options,&block)
        superclass = options.fetch(:extend){ controller_class }
        includes = Array(options[:includes])

        klass = Class.new(superclass)

        includes.each do |include|
          klass.send :include, include
        end

        klass.send :define_method, Parapets::Controller::DEFAULT_ACTION, &block

        klass
      end
    end
  end
end

require 'parapets/controller/api'
require 'parapets/controller/proxy'
