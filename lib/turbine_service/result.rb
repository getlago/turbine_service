# frozen_string_literal: true

module TurbineService
  class Result
    attr_reader :error

    def initialize
      @failure = false
      @error = nil
    end

    def failure?
      failure
    end

    def success?
      !failure
    end

    def fail_with_error!(error)
      @failure = true
      @error = error

      self
    end

    def forbidden_failure!(code: "feature_unavailable")
      fail_with_error!(Failures::ForbiddenFailure.new(self, code))
    end

    def not_allowed_failure!(code:)
      fail_with_error!(Failures::NotAllowedFailure.new(self, code))
    end

    def not_found_failure!(resource:)
      fail_with_error!(Failures::NotFoundFailure.new(self, resource))
    end

    def service_failure!(code:, message:)
      fail_with_error!(Failures::ServiceFailure.new(self, code, message))
    end

    def unauthorized_failure!(code: "unauthorized")
      fail_with_error!(Failures::UnauthorizedFailure.new(self, code))
    end

    def validation_failure!(errors:)
      fail_with_error!(Failures::ValidationFailure.new(self, errors))
    end

    def record_validation_failure!(record)
      validation_failure!(errors: record.errors.messages)
    end

    def single_validation_failure!(code:, field: :base)
      validation_failure!(errors: {field.to_sym => [code]})
    end

    def raise_if_error!
      return self if success?

      raise(error)
    end

    private

    attr_accessor :failure
  end
end
