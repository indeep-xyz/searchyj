# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'searchyj/version'

Gem::Specification.new do |spec|
  spec.name          = "searchyj"
  spec.version       = SearchYJ::VERSION
  spec.authors       = ["indeep-xyz"]
  spec.email         = ["indeep.xyz@gmail.com"]

  spec.summary       = %q{Search on Yahoo Japan}
  spec.description   = %q{Search on Yahoo Japan}
  spec.homepage      = "https://github.com/indeep-xyz/searchyj"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = ['searchyj']
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri", '~> 1.6.6.2'
  spec.add_dependency "thor", '~> 0.19.1'
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rubocop", "~> 0.32.0"
end
