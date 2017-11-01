# frozen_string_literal: true

require "securerandom"
require "hanami/utils/files"

module RSpec
  module Support
    module WithProject
      private

      # rubocop:disable Metrics/AbcSize
      # rubocop:disable Metrics/MethodLength
      def with_project
        gem_root   = Pathname.new(__dir__).join("..", "..").expand_path
        tmp        = gem_root.join("tmp")
        random_tmp = tmp.join(SecureRandom.hex(8))

        project      = "bookshelf"
        project_root = random_tmp.join(project)
        Hanami::Utils::Files.mkdir(random_tmp)

        Dir.chdir(random_tmp) do
          system "bundle exec hanami new #{project}"
        end

        Bundler.with_clean_env do
          Dir.chdir(project_root) do
            # FIXME: remove this line after hanami-1.1.0.beta2 will be out.
            # Hanami::Utils::Files.replace_first_line("Gemfile", "hanami", %(gem "hanami", github: "hanami/hanami", branch: "develop"))

            Hanami::Utils::Files.append("Gemfile", %(gem "hanami-reloader", groups: [:plugins], path: "#{gem_root}"))
            Hanami::Utils::Files.append("Gemfile", %(gem "pry", groups: [:development]))

            # FIXME: remove this line after hanami-1.1.0.beta2 will be out.
            # system "bundle"

            begin
              yield
            ensure
              Hanami::Utils::Files.delete_directory(tmp)
            end
          end
        end
      end
      # rubocop:enable Metrics/MethodLength
      # rubocop:enable Metrics/AbcSize
    end
  end
end

RSpec.configure do |config|
  config.include RSpec::Support::WithProject, type: :cli
end
