# frozen_string_literal: true

require "pathname"

RSpec.describe Hanami::Reloader::Commands::Server do
  describe "#call" do
    let(:args) { {code_reloading: code_reloading, guardfile: guardfile, port: port} }
    let(:code_reloading) { true }
    let(:guardfile) { Hanami::Reloader::Commands::Guardfile.default_path }
    let(:port) { 2300 }

    context "with default arguments" do
      it "starts server" do
        allow(subject).to receive(:exec).with("bundle exec guard -n f -i -g server -G Guardfile")

        subject.call(**args)
      end

      it "sets Guard Puma env vars" do
        allow(subject).to receive(:exec)
        subject.call(**args)

        expect(ENV.fetch("HANAMI_PORT", nil)).to eq(port.to_s)
      end
    end

    context "with code reloading disabled" do
      subject { described_class.new(server: server) }
      let(:code_reloading) { false }
      let(:server) { proc { |*| } }

      it "starts original hanami-cli server" do
        allow(server).to receive(:call)

        subject.call(**args)
      end
    end

    context "with custom Guardfile path" do
      let(:guardfile) { Pathname.new(Dir.pwd).join("Guardfile") }

      it "uses given value" do
        allow(subject).to receive(:exec).with("bundle exec guard -n f -i -g server -G #{guardfile}")

        subject.call(**args)
      end
    end

    context "hanami-cli server options" do
      context "with custom port" do
        let(:port) { 9000 }

        it "uses given value" do
          allow(subject).to receive(:exec)
          subject.call(**args)

          expect(ENV.fetch("HANAMI_PORT", nil)).to eq(port.to_s)
        end
      end
    end
  end
end
