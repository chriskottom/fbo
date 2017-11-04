require 'rubygems'
require 'bundler/setup'

require 'fbo'
require 'fivemat/minitest/autorun'
require 'mocha/setup'

require "minitest/rg"
require "fivemat/minitest"

module Minitest
  class Spec
    class << self
      alias_method :context, :describe
    end
  end
end
