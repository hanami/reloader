# frozen_string_literal: true

source "https://rubygems.org"
gemspec

unless ENV["CI"]
  gem "byebug", require: false
end

gem "hanami-utils", "~> 2.0.rc", require: false, git: "https://github.com/hanami/utils.git",  branch: "main"
gem "hanami-cli",   "~> 2.0.rc", require: false, git: "https://github.com/hanami/cli.git",    branch: "main"
gem "hanami",       "~> 2.0.rc", require: false, git: "https://github.com/hanami/hanami.git", branch: "main"

gem "hanami-devtools", require: false, git: "https://github.com/hanami/devtools.git", branch: "main"
