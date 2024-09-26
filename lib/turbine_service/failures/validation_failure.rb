# frozen_string_literal: true

require "json"

module TurbineService
  module Failures
    class ValidationFailure < BaseFailure
      attr_reader :messages

      def initialize(result, messages)
        @messages = messages

        super(result, format_messages)
      end

      private

      def format_messages
        "Validation errors: #{messages.to_json}"
      end
    end
  end
end
