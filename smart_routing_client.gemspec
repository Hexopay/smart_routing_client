# frozen_string_literal: true
#

Gem::Specification.new do |spec|
  spec.name        = 'smart_routing_client'
  spec.version     = SmartRouting::VERSION
  spec.required_ruby_version = '>= 2.3.0'
  spec.authors     = ['Andrey Eremeev']
  spec.email       = ['andrey@hexopay.com']
  spec.homepage    = 'https://github.com/hexopay/smart_routing_client'
  spec.summary     = 'Implement Smart Routing to get gataway'
  spec.description = 'Implement Smart Routing to get gataway'
  spec.license     = 'MIT'
  spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://rubygems.org'
  spec.metadata['changelog_uri'] = 'https://rubygems.org'
  spec.files = Dir['{app,config,db,lib}/**/*',
                   'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.executables << 'smart_routing'
end

