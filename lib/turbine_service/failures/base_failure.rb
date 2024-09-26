# frozen_string_literal: true

module TurbineService
  module Failures
    class BaseFailure < StandardError
      attr_reader :result

      def initialize(result, message)
        @result = result

        super(message)
      end
    end
  end
end
