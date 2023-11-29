# frozen_string_literal: true

require_relative "lib/k3cloud/version"

Gem::Specification.new do |spec|
  spec.name = "k3cloud-sdk"
  spec.version = K3cloud::VERSION
  spec.authors = ["zevinto"]
  spec.email = ["zevinto@163.com"]

  spec.summary = "Ruby Gem for K3cloud API."
  spec.description = "Ruby Gem for K3cloud OpenApi that uses cryptographic signature technology to avoid plaintext transmission of keys and enables automatic login."
  spec.homepage = "https://github.com/zevinto/k3cloud-sdk"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.0.0"
  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "bin"
  spec.executables = spec.files.grep(%r{\Abin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "faraday"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
