# -*- encoding: utf-8 -*-
# stub: tinymce-rails 4.7.13 ruby lib

Gem::Specification.new do |s|
  s.name = "tinymce-rails".freeze
  s.version = "4.7.13"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Sam Pohlenz".freeze]
  s.date = "2018-05-16"
  s.description = "Seamlessly integrates TinyMCE into the Rails asset pipeline introduced in Rails 3.1.".freeze
  s.email = "sam@sampohlenz.com".freeze
  s.homepage = "https://github.com/spohlenz/tinymce-rails".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.7.6".freeze
  s.summary = "Rails asset pipeline integration for TinyMCE.".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>.freeze, [">= 3.1.1"])
    else
      s.add_dependency(%q<railties>.freeze, [">= 3.1.1"])
    end
  else
    s.add_dependency(%q<railties>.freeze, [">= 3.1.1"])
  end
end
