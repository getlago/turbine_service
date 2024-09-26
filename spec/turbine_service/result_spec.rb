# frozen_string_literal: true

require "spec_helper"

require_relative "../support/validation_error"

RSpec.describe TurbineService::Result do
  subject(:result) { described_class.new }

  it { expect(result).to be_success }
  it { expect(result).not_to be_failure }
  it { expect(result.error).to be_nil }

  it { expect(result.raise_if_error!).to eq(result) }

  describe ".fail_with_error!" do
    let(:error) { StandardError.new("custom_error") }

    it "assign the error the result", :aggregate_failures do
      failure = result.fail_with_error!(error)

      expect(failure).to eq(result)
      expect(result).not_to be_success
      expect(result).to be_failure
      expect(result.error).to eq(error)
    end
  end

  describe ".forbidden_failure!" do
    before { result.forbidden_failure! }

    it { expect(result).not_to be_success }
    it { expect(result).to be_failure }
    it { expect(result.error).to be_a(TurbineService::Failures::ForbiddenFailure) }
    it { expect(result.error.code).to eq("feature_unavailable") }

    it { expect { result.raise_if_error! }.to raise_error(TurbineService::Failures::ForbiddenFailure) }

    context "when passing a code to the failure" do
      before { result.forbidden_failure!(code: "custom_code") }

      it { expect(result.error.code).to eq("custom_code") }
    end
  end

  describe ".not_allowed_failure!" do
    before { result.not_allowed_failure!(code: "custom_code") }

    it { expect(result).not_to be_success }
    it { expect(result).to be_failure }
    it { expect(result.error).to be_a(TurbineService::Failures::NotAllowedFailure) }
    it { expect(result.error.code).to eq("custom_code") }

    it { expect { result.raise_if_error! }.to raise_error(TurbineService::Failures::NotAllowedFailure) }
  end

  describe ".not_found_failure!" do
    before { result.not_found_failure!(resource: "custom_resource") }

    it { expect(result).not_to be_success }
    it { expect(result).to be_failure }
    it { expect(result.error).to be_a(TurbineService::Failures::NotFoundFailure) }
    it { expect(result.error.code).to eq("custom_resource_not_found") }

    it { expect { result.raise_if_error! }.to raise_error(TurbineService::Failures::NotFoundFailure) }
  end

  describe ".service_failure!" do
    before { result.service_failure!(code: "custom_code", message: "custom_message") }

    it { expect(result).not_to be_success }
    it { expect(result).to be_failure }
    it { expect(result.error).to be_a(TurbineService::Failures::ServiceFailure) }
    it { expect(result.error.code).to eq("custom_code") }
    it { expect(result.error.message).to eq("custom_code: custom_message") }

    it { expect { result.raise_if_error! }.to raise_error(TurbineService::Failures::ServiceFailure) }
  end

  describe ".unauthorized_failure!" do
    before { result.unauthorized_failure! }

    it { expect(result).not_to be_success }
    it { expect(result).to be_failure }
    it { expect(result.error).to be_a(TurbineService::Failures::UnauthorizedFailure) }
    it { expect(result.error.code).to eq("unauthorized") }

    it { expect { result.raise_if_error! }.to raise_error(TurbineService::Failures::UnauthorizedFailure) }

    context "when passing a code to the failure" do
      before { result.unauthorized_failure!(code: "custom_code") }

      it { expect(result.error.code).to eq("custom_code") }
    end
  end

  describe ".validation_failure!" do
    before { result.validation_failure!(errors: {field: ["error"]}) }

    it { expect(result).not_to be_success }
    it { expect(result).to be_failure }
    it { expect(result.error).to be_a(TurbineService::Failures::ValidationFailure) }
    it { expect(result.error.messages).to eq({field: ["error"]}) }
    it { expect(result.error.message).to eq('Validation errors: {"field":["error"]}') }

    it { expect { result.raise_if_error! }.to raise_error(TurbineService::Failures::ValidationFailure) }
  end

  describe ".record_validation_failure!" do
    let(:resource) do
      Resource.new(ValidationErrors.new({field: ["error"]}))
    end

    before { result.record_validation_failure!(resource) }

    it { expect(result).not_to be_success }
    it { expect(result).to be_failure }
    it { expect(result.error).to be_a(TurbineService::Failures::ValidationFailure) }
    it { expect(result.error.messages).to eq({field: ["error"]}) }
    it { expect(result.error.message).to eq('Validation errors: {"field":["error"]}') }

    it { expect { result.raise_if_error! }.to raise_error(TurbineService::Failures::ValidationFailure) }
  end

  describe ".single_validation_failure!" do
    before { result.single_validation_failure!(code: "error") }

    it { expect(result).not_to be_success }
    it { expect(result).to be_failure }
    it { expect(result.error).to be_a(TurbineService::Failures::ValidationFailure) }
    it { expect(result.error.messages).to eq({base: ["error"]}) }
    it { expect(result.error.message).to eq('Validation errors: {"base":["error"]}') }

    it { expect { result.raise_if_error! }.to raise_error(TurbineService::Failures::ValidationFailure) }

    context "when passing a field to the failure" do
      before { result.single_validation_failure!(code: "error", field: "field") }

      it { expect(result.error.messages).to eq({field: ["error"]}) }
      it { expect(result.error.message).to eq('Validation errors: {"field":["error"]}') }
    end
  end
end
