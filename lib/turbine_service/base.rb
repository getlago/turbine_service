# frozen_string_literal: true

module TurbineService
  class Base
    Result = TurbineService::Result

    def self.call(*args, **keyword_args, &block)
      new(*args, **keyword_args).call(&block)
    end

    def initialize(*, **)
      @result = self.class::Result.new
    end

    def call(**args, &block)
      raise NotImplementedError
    end

    private

    attr_reader :result
  end
end
