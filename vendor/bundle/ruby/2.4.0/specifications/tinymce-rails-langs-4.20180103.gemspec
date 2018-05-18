# -*- encoding: utf-8 -*-
# stub: tinymce-rails-langs 4.20180103 ruby lib

Gem::Specification.new do |s|
  s.name = "tinymce-rails-langs".freeze
  s.version = "4.20180103"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Sam Pohlenz".freeze]
  s.date = "2018-01-03"
  s.description = "Additional language packs for tinymce-rails.".freeze
  s.email = "sam@sampohlenz.com".freeze
  s.homepage = "https://github.com/spohlenz/tinymce-rails-langs".freeze
  s.rubygems_version = "2.7.6".freeze
  s.summary = "Additional language packs for tinymce-rails.".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<tinymce-rails>.freeze, [">= 4.1.10", "~> 4.1"])
    else
      s.add_dependency(%q<tinymce-rails>.freeze, [">= 4.1.10", "~> 4.1"])
    end
  else
    s.add_dependency(%q<tinymce-rails>.freeze, [">= 4.1.10", "~> 4.1"])
  end
end
