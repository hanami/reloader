# frozen_string_literal: true

require "zeitwerk"

module Hanami
  # Hanami reloader
  module Reloader
    def self.gem_loader
      @gem_loader ||= Zeitwerk::Loader.new.tap do |loader|
        root = File.expand_path("..", __dir__)
        loader.tag = "hanami-reloader"
        loader.inflector = Zeitwerk::GemInflector.new("#{root}/hanami-reloader.rb")
        loader.push_dir(root)
        loader.ignore(
          "#{root}/hanami-reloader.rb",
          "#{root}/hanami/controller/version.rb"
        )
      end
    end

    gem_loader.setup
    require_relative "reloader/commands"
  end
end
