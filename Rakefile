require 'bundler/gem_tasks'

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs += %w( spec test )
  t.pattern = '{spec,test}/**/*_{spec,test}.rb'
  t.ruby_opts = ['-W0']
end

task default: [:test]
