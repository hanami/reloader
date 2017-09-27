RSpec.describe "CLI: hanami generate reloader", type: :cli do
  it "generates Guardfile" do
    with_project do
      system "bundle exec hanami generate reloader"

      expect(File.exist?("Guardfile")).to be(true)

      expected = <<-EOF
guard "rack", port: ENV["HANAMI_PORT"] || 2300 do
  watch(%r{config/*})
  watch(%r{lib/*})
  watch(%r{apps/*})
end

EOF

      expect(File.read("Guardfile")).to eq(expected)
    end
  end
end
