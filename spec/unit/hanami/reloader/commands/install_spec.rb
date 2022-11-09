# frozen_string_literal: true

require "hanami/reloader/commands"
require "hanami/cli/bundler"

require "tmpdir"

RSpec.describe Hanami::Reloader::Commands::Install do
  describe "#call" do
    subject { described_class.new(fs: fs, bundler: bundler) }

    let(:fs) { Dry::Files.new }
    let(:dir) { Dir.mktmpdir }
    let(:app) { "synth" }
    let(:app_name) { "Synth" }

    let(:bundler) { instance_spy(Hanami::CLI::Bundler) }

    let(:arbitrary_argument) { {} }

    around do |example|
      fs.chdir(dir) { example.run }
    ensure
      fs.delete_directory(dir)
    end

    it "generates configurations" do
      subject.call(arbitrary_argument)

      # Gemfile
      gemfile = <<~EOF
        group :development do
          gem "guard-puma"
        end
      EOF
      expect(fs.read("Gemfile")).to include(gemfile)

      # Guardfile
      guardfile = <<~EOF
        # frozen_string_literal: true

        group :server do
          guard "puma", port: ENV["HANAMI_PORT"] || 2300 do
            watch(%r{config/*})
            watch(%r{lib/*})
            watch(%r{app/*})
            watch(%r{slices/*})
          end
        end
      EOF
      expect(fs.read("Guardfile")).to eq(guardfile)
    end

    it "runs bundle install" do
      subject.call(arbitrary_argument)
      expect(bundler).to have_received(:install!)
    end
  end
end
