# frozen_string_literal: true

source "https://rubygems.org"
gemspec

unless ENV["CI"]
  gem "byebug"
end

gem "hanami",          git: "https://github.com/hanami/hanami.git", branch: "1.3.x"
gem "hanami-devtools", git: "https://github.com/hanami/devtools.git", branch: "1.3.x"
gem "hanami-model", "~> 1.3"
