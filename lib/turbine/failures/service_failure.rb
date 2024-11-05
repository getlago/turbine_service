# frozen_string_literal: true

module Turbine
  module Failures
    class ServiceFailure < BaseFailure
      attr_reader :code, :error_message

      def initialize(result, code, error_message)
        @code = code
        @error_message = error_message

        super(result, "#{code}: #{error_message}")
      end
    end
  end
end
