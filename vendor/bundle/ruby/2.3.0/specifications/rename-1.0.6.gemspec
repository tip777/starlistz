# -*- encoding: utf-8 -*-
# stub: rename 1.0.6 ruby lib

Gem::Specification.new do |s|
  s.name = "rename"
  s.version = "1.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Morshed Alam"]
  s.date = "2017-04-23"
  s.email = ["morshed201@gmail.com"]
  s.homepage = "https://github.com/morshedalam/rename"
  s.licenses = ["MIT"]
  s.rubyforge_project = "rename"
  s.rubygems_version = "2.5.1"
  s.summary = "Rename your Rails application using a single command."

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 3.0.0"])
      s.add_runtime_dependency(%q<thor>, [">= 0.19.1"])
      s.add_runtime_dependency(%q<activesupport>, [">= 0"])
    else
      s.add_dependency(%q<rails>, [">= 3.0.0"])
      s.add_dependency(%q<thor>, [">= 0.19.1"])
      s.add_dependency(%q<activesupport>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 3.0.0"])
    s.add_dependency(%q<thor>, [">= 0.19.1"])
    s.add_dependency(%q<activesupport>, [">= 0"])
  end
end
