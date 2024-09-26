# frozen_string_literal: true

require "turbine_service/version"

# Base structure
require "turbine_service/result"
require "turbine_service/base"

# Failures
require "turbine_service/failures/base_failure"
require "turbine_service/failures/forbidden_failure"
require "turbine_service/failures/not_allowed_failure"
require "turbine_service/failures/not_found_failure"
require "turbine_service/failures/service_failure"
require "turbine_service/failures/unauthorized_failure"
require "turbine_service/failures/validation_failure"
