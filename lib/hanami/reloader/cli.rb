# frozen_string_literal: true

module Hanami
  module Reloader
    module CLI
      # Guardfile
      module Guardfile
        def self.group
          "server"
        end

        def self.default_path
          path("Guardfile")
        end

        def self.path(path)
          Hanami.root.join(path)
        end
      end

      # Generate hanami-reloader configuration
      class Generate < Hanami::CLI::Commands::Command
        desc "Generate configuration for code reloading"

        option :guardfile, type: :string,  desc: "Path to Guardfile",               default: Guardfile.default_path.to_s
        option :puma,      type: :boolean, desc: "Generate configuration for Puma", default: false

        def call(**args)
          path = Guardfile.path(args.fetch(:guardfile))
          puma = args.fetch(:puma)

          generate_configuration(path, puma)
          bundle_gems(puma)
        end

        private

        def generate_configuration(path, puma)
          guard = puma ? "puma" : "rack"

          files.touch(path)
          files.append path, <<~CODE
            group :#{Guardfile.group} do
              guard "#{guard}", port: ENV["HANAMI_PORT"] || 2300 do
                watch(%r{config/*})
                watch(%r{lib/*})
                watch(%r{apps/*})
              end
            end
          CODE
        end

        def bundle_gems(puma)
          return unless puma

          exec "bundle add guard-puma --skip-install --group=development"
        end
      end

      # Override `hanami server` command
      class Server < Hanami::CLI::Commands::Server
        option :guardfile,      type: :string,  desc: "Path to Guardfile", default: Guardfile.default_path.to_s
        option :code_reloading, type: :boolean, desc: "Code reloading",    default: true

        example [
          "--no-code-reloading # Disable code reloading"
        ]

        def call(**args)
          code_reloading = args.fetch(:code_reloading)
          super unless code_reloading

          path = Guardfile.path(args.fetch(:guardfile))
          exec "bundle exec guard -n f -i -g #{Guardfile.group} -G #{path}"
        end
      end
    end
  end
end

Hanami::CLI.register "generate reloader", Hanami::Reloader::CLI::Generate
Hanami::CLI.register "server",            Hanami::Reloader::CLI::Server
