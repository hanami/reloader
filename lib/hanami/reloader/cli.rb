# frozen_string_literal: true

module Hanami
  module Reloader
    module CLI
      # Generate hanami-reloader configuration
      class Generate < Hanami::CLI::Commands::Command
        requires "environment"

        desc "Generate configuration for code reloading"

        def call(*)
          path = Hanami.root.join("Guardfile")

          files.touch(path)
          files.append path, <<~CODE
            guard "rack", port: ENV["HANAMI_PORT"] || 2300 do
              watch(%r{config/*})
              watch(%r{lib/*})
              watch(%r{apps/*})
            end
CODE
        end
      end

      # Override `hanami server` command
      class Server < Hanami::CLI::Commands::Command
        desc "Starts the server with code reloading (only development) reloader"

        def call(*)
          exec "bundle exec guard -i"
        end
      end
    end
  end
end

Hanami::CLI.register "generate reloader", Hanami::Reloader::CLI::Generate
Hanami::CLI.register "server",            Hanami::Reloader::CLI::Server
