require 'rubygems'
require 'bundler/setup'

require 'fbo'
require 'minitest/autorun'
require 'mocha/setup'
require 'turn/autorun'

Turn.config do |c|   
  c.format = :outline
  c.trace = 8
  c.natural = true
end

module MiniTest
  class Spec
    class << self
      alias_method :context, :describe
    end
  end
end
