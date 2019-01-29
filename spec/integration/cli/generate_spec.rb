# frozen_string_literal: true

RSpec.describe "CLI: hanami generate reloader", type: :integration do
  it "generates Guardfile" do
    with_project do
      guardfile = Pathname.new(Dir.pwd).join("Guardfile")
      guardfile.delete if guardfile.exist?

      bundle_exec "hanami generate reloader"
      expect(guardfile.exist?).to be(true)

      expected = <<~CODE
        group :server do
          guard "rack", port: ENV["HANAMI_PORT"] || 2300 do
            watch(%r{config/*})
            watch(%r{lib/*})
            watch(%r{apps/*})
          end
        end

      CODE

      expect(guardfile.read).to eq(expected)
      guardfile.delete
    end
  end

  private

  def with_project
    root = Pathname.new(Dir.pwd).join("spec", "fixtures", "bookshelf").realpath
    RSpec::Support::Env["BUNDLE_GEMFILE"] = root.join("Gemfile").to_s

    with_directory(root) do
      bundle_install
      yield
    end
  end
end
