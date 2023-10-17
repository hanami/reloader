# frozen_string_literal: true

require "hanami/reloader/commands"

RSpec.describe "Hanami::Reloader::Commands::Install::MATCHER" do
  subject { Hanami::Reloader::Commands::Install::MATCHER }

  let(:matching_paths) do
    [
      "app/action.rb",
      "app/view.rb",
      "app/actions/books/index.rb",
      "app/actions/books/discounted/index.rb",
      "app/views/helpers.rb",
      "app/views/books/index.rb",
      "app/views/books/discounted/index.rb",
      "app/templates/books/index.html.erb",
      "app/templates/books/discounted/index.html.erb",
      "app/templates/layouts/app.html.erb",
      "config/app.rb",
      "config/puma.rb",
      "config/routes.rb",
      "config/settings.rb",
      "lib/bookshelf/types.rb",
      "slices/admin/action.rb",
      "slices/admin/view.rb",
      "slices/admin/actions/users/index.rb",
      "slices/admin/actions/users/deactivated/index.rb",
      "slices/admin/views/helpers.rb",
      "slices/admin/views/users/index.rb",
      "slices/admin/views/users/deactivated/index.rb",
      "slices/admin/templates/users/index.html.slim",
      "slices/admin/templates/users/deactivated/index.html.slim",
      "slices/api/templates/authors/index.json.haml",
      "slices/api/templates/authors/uprising/index.json.haml"
    ]
  end

  let(:non_matching_paths) do
    [
      "Gemfile",
      "Gemfile.lock",
      "Guardfile",
      "Procfile.dev",
      "README.md",
      "Rakefile",
      "config.ru",
      "app/assets/css/app.css",
      "app/assets/js/app.js",
      "app/assets/images/favicon.ico",
      "slices/admin/assets/css/app.css",
      "slices/admin/assets/js/app.js",
      "slices/admin/assets/images/favicon.ico",
      "log/test.log",
      "node_modules/hanami-assets/dist/hanami-assets.js",
      "package.json",
      "package-lock.json",
      "package.json",
      "public/assets.json",
      "public/assets/favicon.ico",
      "spec/spec_helper.rb",
      "spec/requests/root_spec.rb",
      "spec/support/requests.rb",
      "spec/support/rspec.rb",
      "spec/actions/books/index_spec.rb",
      "spec/actions/books/discounted/index_spec.rb",
      "spec/views/books/index_spec.rb",
      "spec/views/books/discounted/index_spec.rb"
    ]
  end

  context "UNIX" do
    it "matches the given patterns" do
      matching_paths.each do |path|
        expect(path).to match(subject)
      end
    end

    it "does not matches the given patterns" do
      non_matching_paths.each do |path|
        expect(path).to_not match(subject)
      end
    end
  end

  context "Windows" do
    it "matches the given patterns" do
      matching_paths.each do |path|
        expect(windows_path(path)).to match(subject)
      end
    end

    it "does not matches the given patterns" do
      non_matching_paths.each do |path|
        expect(windows_path(path)).to_not match(subject)
      end
    end

    private

    def windows_path(path)
      path.gsub("/", "\\")
    end
  end
end
