require 'active_support/concern'

module Parapets
  module Versionable
    extend ActiveSupport::Concern

    module ClassMethods
      def version(version_id,options={},&block)

        # If a block is provided we are defininfg a new version.
        if block
          versions[version_id] = build_version(version_id,options,&block)
        end

        # Find the actual implemented version_id
        actual_version_id = versions_ids.reverse.find{ |id| id <= version_id }

        # Return the compatible version
        versions[actual_version_id]
      end

      def versions_ids
        versions.keys.sort
      end

      def latest_version
        versions_ids.last
      end

      private
        def versions
          @versions ||= {}
        end

        def build_version(version_id,options,&block)
          raise NotImplementedError, "Must implement #build_version class method to support versioning"
        end
    end
  end
end

