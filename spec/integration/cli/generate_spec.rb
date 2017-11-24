# frozen_string_literal: true

RSpec.describe "CLI: hanami generate reloader", type: :cli do
  it "generates Guardfile" do
    with_project do
      system "bundle exec hanami generate reloader"

      expect(File.exist?(".hanami.server.guardfile")).to be(true)

      expected = <<~CODE
        guard "rack", port: ENV["HANAMI_PORT"] || 2300 do
          watch(%r{config/*})
          watch(%r{lib/*})
          watch(%r{apps/*})
        end

CODE

      expect(File.read(".hanami.server.guardfile")).to eq(expected)
    end
  end
end
