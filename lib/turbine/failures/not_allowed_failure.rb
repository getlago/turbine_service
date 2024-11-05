# frozen_string_literal: true

module Turbine
  module Failures
    class NotAllowedFailure < BaseFailure
      attr_reader :code

      def initialize(result, code)
        @code = code

        super
      end
    end
  end
end
