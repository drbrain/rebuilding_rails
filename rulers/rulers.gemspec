# -*- encoding: utf-8 -*-
# stub: rulers 1.0.20200609182203 ruby lib

Gem::Specification.new do |s|
  s.name = "rulers".freeze
  s.version = "1.0.20200609182203"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/drbrain/rulers/issues", "homepage_uri" => "https://github.com/drbrain/rulers" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Eric Hodel".freeze]
  s.cert_chain = ["/Users/erichodel/.gem/gem-public_cert.pem".freeze]
  s.date = "2020-06-10"
  s.description = "A Rack-based Web Framework from Rebuilding Rails".freeze
  s.email = ["drbrain@segment7.net".freeze]
  s.extra_rdoc_files = ["History.rdoc".freeze, "Manifest.txt".freeze, "README.rdoc".freeze]
  s.files = [".autotest".freeze, "History.rdoc".freeze, "Manifest.txt".freeze, "README.rdoc".freeze, "Rakefile".freeze, "lib/rulers.rb".freeze]
  s.homepage = "https://github.com/drbrain/rulers".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--main".freeze, "README.rdoc".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.signing_key = nil
  s.summary = "A Rack-based Web Framework from Rebuilding Rails".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>.freeze, ["~> 2.0"])
      s.add_runtime_dependency(%q<erubis>.freeze, ["~> 2.7"])
      s.add_development_dependency(%q<minitest>.freeze, ["~> 5.14"])
      s.add_development_dependency(%q<rack-test>.freeze, ["~> 1.1"])
      s.add_development_dependency(%q<rdoc>.freeze, [">= 4.0", "< 7"])
      s.add_development_dependency(%q<hoe>.freeze, ["~> 3.22"])
    else
      s.add_dependency(%q<rack>.freeze, ["~> 2.0"])
      s.add_dependency(%q<erubis>.freeze, ["~> 2.7"])
      s.add_dependency(%q<minitest>.freeze, ["~> 5.14"])
      s.add_dependency(%q<rack-test>.freeze, ["~> 1.1"])
      s.add_dependency(%q<rdoc>.freeze, [">= 4.0", "< 7"])
      s.add_dependency(%q<hoe>.freeze, ["~> 3.22"])
    end
  else
    s.add_dependency(%q<rack>.freeze, ["~> 2.0"])
    s.add_dependency(%q<erubis>.freeze, ["~> 2.7"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.14"])
    s.add_dependency(%q<rack-test>.freeze, ["~> 1.1"])
    s.add_dependency(%q<rdoc>.freeze, [">= 4.0", "< 7"])
    s.add_dependency(%q<hoe>.freeze, ["~> 3.22"])
  end
end
