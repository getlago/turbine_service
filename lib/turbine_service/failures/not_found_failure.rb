# frozen_string_literal: true

module TurbineService
  module Failures
    class NotFoundFailure < BaseFailure
      attr_reader :resource

      def initialize(result, resource)
        @resource = resource

        super(result, code)
      end

      def code
        "#{resource}_not_found"
      end
    end
  end
end
