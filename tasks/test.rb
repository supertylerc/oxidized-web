require 'rspec/core/rake_task'

namespace :test do
  desc 'Run RSpec tests'
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = Dir.glob('spec/**/*_spec.rb')
    t.rspec_opts = ['--format', 'documentation', '--color']
  end
end
