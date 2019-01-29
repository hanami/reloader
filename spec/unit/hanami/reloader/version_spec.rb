# frozen_string_literal: true

RSpec.describe "Hanami::Reloader::VERSION" do
  it "exposes version" do
    expect(Hanami::Reloader::VERSION).to eq("0.3.0")
  end
end
