# -*- encoding: utf-8 -*-
# stub: bootstrap-tagsinput-rails 0.4.2.1 ruby lib

Gem::Specification.new do |s|
  s.name = "bootstrap-tagsinput-rails".freeze
  s.version = "0.4.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Hyo Seong Choi".freeze]
  s.date = "2014-10-07"
  s.description = "To gemify bootstrap-tagsinput for assets pipleline".freeze
  s.email = ["rorlab@gmail.com".freeze]
  s.homepage = "http://rorlab.github.io/bootstrap-tagsinput-rails/".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.7.6".freeze
  s.summary = "Packaging the assets with Bunlder".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>.freeze, [">= 3.1"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<railties>.freeze, [">= 3.1"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<railties>.freeze, [">= 3.1"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
