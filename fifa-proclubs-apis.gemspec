lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative 'lib/fifa/game/version'

Gem::Specification.new do |spec|
  spec.name = 'fifa-proclubs-apis'
  spec.version = Fifa::Game::VERSION
  spec.authors = ['Lonny Antunes']
  spec.email = ['lonny.antunes@gmail.fr']

  spec.summary = 'A summary'
  spec.description = 'A description'
  spec.license = 'MIT'

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  #
  # spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.files = `find . -type f`.split("\n").reject do |f|
    f.match(/^\.\/(?:test|spec|features|.*\.git.*|\.idea.*|build_gem\.sh|conf\.pstore|.*\.gem|.*README\.md)$/)
  end
  spec.bindir = 'bin'
  spec.executables = ['fifa-proclubs-apis']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'guard-rspec', '~> 4.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'webmock', '~> 3.4'

  spec.add_runtime_dependency 'thor'
  spec.add_runtime_dependency 'artii', '~> 2.1.2'
  spec.add_runtime_dependency 'gemoji', '~> 3.0.1'
  spec.add_runtime_dependency 'pastel', '~> 0.7.3'
  spec.add_runtime_dependency 'tty-box', '~> 0.5.0'
  spec.add_runtime_dependency 'tty-prompt', '~> 0.20.0'
end
