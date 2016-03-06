
module Npm
  module Rails
    class PackageBundler

      def self.bundle(root_path, package_file, env, &block)
        new.bundle(root_path, package_file, env, &block)
      end

      def bundle(root_path, package_file, env, &block)
        @root_path = root_path
        @package_file = package_file
        @env = env

        if File.exist?("#{ root_path }/#{ package_file }")
          bundle_file_path = package_manager.write_bundle_file
          if block_given?
            yield package_manager.to_npm_format, bundle_file_path
          end
        else
          raise PackageFileNotFound, "#{ package_file } not found! Make sure you have it at the root of your project"
        end
      end

      private

      def package_manager
        @package_manager ||= PackageManager.build(@root_path, @package_file, @env)
      end
    end
  end
end
