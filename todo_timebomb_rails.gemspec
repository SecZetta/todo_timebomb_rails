require_relative 'lib/todo_timebomb/version'

Gem::Specification.new do |spec|
  spec.name          = "todo_timebomb_rails"
  spec.version       = TodoTimebomb::VERSION
  spec.authors       = ["Brian Brazil"]
  spec.email         = ["bbrazil@seczetta.com"]

  spec.summary       = 'Turns todos into todones'
  spec.description   = 'todos & fixmes tend to lurk around in code forever, but now you can set expiration dates.'
  spec.homepage      = 'https://github.com/SecZetta/todo_timebomb_rails'
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = 'https://github.com/SecZetta/todo_timebomb_rails'
  spec.metadata["changelog_uri"] = 'https://github.com/SecZetta/todo_timebomb_rails'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
