# frozen_string_literal: true

require "rubygems"
require "bundler"
require "rake"
require "rspec/core/rake_task"
require "standard/rake"
require "rubocop/rake_task"

RSpec::Core::RakeTask.new(:spec)

RuboCop::RakeTask.new

task default: %i[spec rubocop]
