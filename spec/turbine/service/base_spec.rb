# frozen_string_literal: true

require "spec_helper"

class DummyService < Turbine::Service::Base
  def initialize(message:)
    @message = message

    super
  end

  def call
    yield @message if block_given?

    result.message = @message
    result
  end
end

class DummyService::Result < Turbine::Service::Result
  attr_accessor :message
end

class DummyServiceWithoutResult < Turbine::Service::Base
  def initialize(message:)
    @message = message

    super
  end

  def call
    yield @message if block_given?

    result
  end
end

RSpec.describe Turbine::Service::Base do
  describe "#call" do
    it { expect { described_class.call }.to raise_error(NotImplementedError) }

    context "with an implemented #call method" do
      subject(:result) { DummyService.call(message: "foo") }

      it { expect(result).to be_a(DummyService::Result) }
      it { expect(result).to be_success }
      it { expect(result.message).to eq("foo") }

      it "yields the block" do
        expect { |block| DummyService.call(message: "foo", &block) }.to yield_with_args("foo")
      end
    end

    context "without result definition" do
      subject(:result) { DummyServiceWithoutResult.call(message: "foo") }

      it { expect(result).to be_a(Turbine::Service::Result) }
      it { expect(result).to be_success }
    end
  end
end
