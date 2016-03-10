# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wercker_bundle_update_pr/version'

Gem::Specification.new do |spec|
  spec.name          = "wercker-bundle-update-pr"
  spec.version       = WerckerBundleUpdatePr::VERSION
  spec.authors       = ["Hirofumi Wakasugi"]
  spec.email         = ["baenej@gmail.com"]

  spec.summary       = %q{An automation script to bundle update and send pull request via Wercker's Trigger Build API}
  spec.description   = %q{Request trigger build to Wercker with an environment variable which instruct wercker.yml to execute this script, then it invoke bundle update, then commit changes and send pull request to GitHub repository.}
  spec.homepage      = "https://github.com/5t111111/wercker-bundle-update-pr"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "octokit", "~> 4.3"
  spec.add_runtime_dependency "compare_linker", "~> 1.2"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
