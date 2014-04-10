module Parapets
  module Railties
    module Routing

      class Mapper < ActionDispatch::Routing::Mapper

        def resource(*resources, &block)
          options = resources.extract_options!.dup

          if apply_common_behavior_for(:resource, resources, options, &block)
            return self
          end

          resource_scope(:resource, SingletonResource.new(resources.pop, options)) do
            yield if block_given?

            concerns(options[:concerns]) if options[:concerns]

            collection do
              post :create, to: resource_action(:create)
            end if parent_resource.actions.include?(:create)

            set_member_mappings_for_resource
          end

          self
        end

        def resources(*resources, &block)
          options = resources.extract_options!.dup

          if apply_common_behavior_for(:resources, resources, options, &block)
            return self
          end

          resource_scope(:resources, Resource.new(resources.pop, options)) do
            yield if block_given?

            concerns(options[:concerns]) if options[:concerns]

            collection do
              if parent_resource.actions.include?(:index)
                get  :index, to: resource_action(:index)
              end
              if parent_resource.actions.include?(:create)
                post :create, to: resource_action(:create)
              end
            end

            set_member_mappings_for_resource
          end

          self
        end

        private
          def resource_action(action)
            "#{parent_resource.controller}_#{action}##{Parapets::Service::Controller::ACTION}"
          end

        def set_member_mappings_for_resource
          member do
            if parent_resource.actions.include?(:show)
              get :show, to: resource_action(:show)
            end
            if parent_resource.actions.include?(:update)
              patch :update, to: resource_action(:update)
            end
            if parent_resource.actions.include?(:destroy)
              delete :destroy, to: resource_action(:destroy)
            end
          end 
        end

      end

    end
  end
end

