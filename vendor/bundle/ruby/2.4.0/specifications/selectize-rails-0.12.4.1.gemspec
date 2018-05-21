# -*- encoding: utf-8 -*-
# stub: selectize-rails 0.12.4.1 ruby lib

Gem::Specification.new do |s|
  s.name = "selectize-rails".freeze
  s.version = "0.12.4.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Manuel van Rijn".freeze]
  s.date = "2017-10-13"
  s.description = "A small gem for putting selectize.js into the Rails asset pipeline".freeze
  s.email = ["manuel@manuelvanrijn.nl".freeze]
  s.homepage = "https://github.com/manuelvanrijn/selectize-rails".freeze
  s.licenses = ["MIT, Apache License v2.0".freeze]
  s.rubygems_version = "2.7.6".freeze
  s.summary = "an asset gemification of the selectize.js plugin".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
