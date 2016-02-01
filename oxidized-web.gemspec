Gem::Specification.new do |s|
  s.name              = 'oxidized-web'
  s.version           = '1.0.0'
  s.licenses          = %w(Apache-2.0)
  s.platform          = Gem::Platform::RUBY
  s.authors           = ['Saku Ytti', 'Samer Abdel-Hafez', 'Tyler Christiansen']
  s.email             = %w(saku@ytti.fi sam@arahant.net code@tylerc.me)
  s.homepage          = 'http://github.com/ytti/oxidized-web'
  s.summary           = 'sinatra API + webUI for oxidized'
  s.description       = 'puma+sinatra+haml webUI + REST API for oxidized'
  s.rubyforge_project = s.name
  s.files             = `git ls-files --other`.split("\n")
  s.executables       = %w( )
  s.require_path      = 'lib'

  s.required_ruby_version =                       '>= 2.0.0'
  s.add_runtime_dependency 'oxidized',            '~> 0.8'
  s.add_runtime_dependency 'puma',                '~> 2.15'
  s.add_runtime_dependency 'sinatra',             '~> 1.4', '>= 1.4.6'
  s.add_runtime_dependency 'sinatra-contrib',     '~> 1.4', '>= 1.4.6'
  s.add_runtime_dependency 'haml',                '~> 4.0'
  s.add_runtime_dependency 'sass',                '~> 3.4'
  s.add_runtime_dependency 'emk-sinatra-url-for', '~> 0.2'
  s.add_runtime_dependency 'sequel',              '~> 4.30'
  s.add_runtime_dependency 'sinatra-sequel',      '~> 0.9'
  s.add_runtime_dependency 'sqlite3',             '~> 1.3'
end
