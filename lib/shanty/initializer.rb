require "thor"

module Shanty
  class Initializer < Thor
    attr_accessor :local_repository_path

    include Thor::Actions

    class << self
      def source_root
        File.dirname(__FILE__)
      end
    end

    desc "", "" #TODO: Figure out how to remove
    def init
      Shanty::DependencyChecker.verify_all
      @local_repository_path = %x(pwd)
      create_home_directory_files
      create_repo_root_files
    end

    no_commands do
      def create_home_directory_files
        directory "templates/shanty", "~/.shanty"
      end

      def create_repo_root_files
        copy_file "templates/Vagrantfile", @local_repository_path
        directory "templates/puppet", File.join(@local_repository_path.strip, "puppet")
      end
    end
  end
end