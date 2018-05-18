# -*- encoding: utf-8 -*-
# stub: tinymce-rails-imageupload 4.0.17.beta.3 ruby lib

Gem::Specification.new do |s|
  s.name = "tinymce-rails-imageupload".freeze
  s.version = "4.0.17.beta.3"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Per Christian B. Viken".freeze]
  s.date = "2017-04-25"
  s.description = "TinyMCE plugin for taking image uploads in Rails >= 3.2. Image storage is handled manually, so works with everything.".freeze
  s.email = ["perchr@northblue.org".freeze]
  s.homepage = "http://eastblue.org/oss".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.7.6".freeze
  s.summary = "TinyMCE plugin for taking image uploads in Rails >= 3.2".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>.freeze, ["< 6", ">= 3.2"])
      s.add_runtime_dependency(%q<tinymce-rails>.freeze, ["~> 4.0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.0"])
      s.add_development_dependency(%q<rails>.freeze, [">= 3.1"])
    else
      s.add_dependency(%q<railties>.freeze, ["< 6", ">= 3.2"])
      s.add_dependency(%q<tinymce-rails>.freeze, ["~> 4.0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.0"])
      s.add_dependency(%q<rails>.freeze, [">= 3.1"])
    end
  else
    s.add_dependency(%q<railties>.freeze, ["< 6", ">= 3.2"])
    s.add_dependency(%q<tinymce-rails>.freeze, ["~> 4.0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.0"])
    s.add_dependency(%q<rails>.freeze, [">= 3.1"])
  end
end
