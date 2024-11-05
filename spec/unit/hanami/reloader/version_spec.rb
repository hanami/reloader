# frozen_string_literal: true

RSpec.describe "Hanami::Reloader::VERSION" do
  it "exposes version" do
    expect(Hanami::Reloader::VERSION).to eq("2.2.0")
  end
end
