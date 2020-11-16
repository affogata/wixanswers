lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'wixanswers/version'

Gem::Specification.new do |spec|
  spec.add_development_dependency 'bundler', '~> 1.0'
  spec.authors = ['Roee Sheelo']
  spec.description = 'A Ruby interface to the WixAnswers API'
  spec.email = %w[roee.sheelo@gmail.com]
  spec.files = %w[CHANGELOG.md LICENSE.md README.md wixanswers.gemspec] + Dir['lib/**/*.rb']
  spec.homepage = 'https://github.com/communit-team/wixanswers'
  spec.licenses = %w[MIT]
  spec.name = 'wixanswers'
  spec.require_paths = %w[lib]
  spec.required_ruby_version = '>= 2.3.1'
  spec.summary = spec.description
  spec.version = WixAnswers::Version
end
