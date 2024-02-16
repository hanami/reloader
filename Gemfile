# frozen_string_literal: true

source "https://rubygems.org"
gemspec

unless ENV["CI"]
  gem "byebug", require: false
  gem "yard", require: false
end

gem "hanami-utils", "~> 2.1.rc", require: false, github: "hanami/utils",  branch: "main"
gem "hanami-cli",   "~> 2.1.rc", require: false, github: "hanami/cli",    branch: "main"
gem "hanami",       "~> 2.1.rc", require: false, github: "hanami/hanami", branch: "main"

gem "hanami-devtools", require: false, github: "hanami/devtools", branch: "main"
