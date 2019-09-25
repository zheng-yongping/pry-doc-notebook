
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "pry-doc-notebook/version"

Gem::Specification.new do |spec|
  spec.name          = "pry-doc-notebook"
  spec.version       = PryDocNotebook::VERSION
  spec.authors       = ["zheng-yongping"]
  spec.email         = ["zheng-yongping@hotmail.com"]

  spec.summary       = %q{Provides YARD and extended documentation support for Pry in IRuby Notebook}
  spec.description   = <<~DESCR
    Pry Doc Notebook is a Pry REPL plugin for IRuby Notebook. It provides a `?`` commands.
    With help of the plugin the commands are be able to display documentation with html format.
  DESCR

  spec.homepage      = "https://github.com/zheng-yongping/pry-doc-notebook"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/zheng-yongping/pry-doc-notebook"
    spec.metadata["changelog_uri"] = "https://github.com/zheng-yongping/pry-doc-notebook/blob/master/CHANGELOG.md"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"

  spec.add_dependency 'yard', '~> 0.9'
  spec.add_dependency 'pry', '~> 0.12'
  spec.add_dependency 'pry-doc', '~> 1.0'
  spec.add_dependency 'rouge'
  spec.add_dependency 'nokogiri'
end
