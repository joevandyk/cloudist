# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{cloudist}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ivan Vanderbyl"]
  s.date = %q{2011-01-16}
  s.description = %q{Cloudist is a simple, highly scalable job queue for Ruby applications, it can run within Rails, or on EC2, and does not load your entire Rails stack like delayed job does.}
  s.email = %q{ivanvanderbyl@me.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "examples/queue_message.rb",
    "examples/sandwich_client.rb",
    "examples/sandwich_worker.rb",
    "lib/cloudist.rb",
    "lib/cloudist/basic_queue.rb",
    "lib/cloudist/core_ext/string.rb",
    "lib/cloudist/errors.rb",
    "lib/cloudist/job.rb",
    "lib/cloudist/job_queue.rb",
    "lib/cloudist/listener.rb",
    "lib/cloudist/payload.rb",
    "lib/cloudist/publisher.rb",
    "lib/cloudist/reply_queue.rb",
    "lib/cloudist/request.rb",
    "lib/cloudist/utils.rb",
    "lib/cloudist/worker.rb",
    "spec/cloudist/basic_queue_spec.rb",
    "spec/cloudist/job_spec.rb",
    "spec/cloudist/payload_spec.rb",
    "spec/cloudist/request_spec.rb",
    "spec/cloudist_spec.rb",
    "spec/core_ext/string_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/ivanvanderbyl/cloudist}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Super fast job queue using AMQP}
  s.test_files = [
    "examples/queue_message.rb",
    "examples/sandwich_client.rb",
    "examples/sandwich_worker.rb",
    "spec/cloudist/basic_queue_spec.rb",
    "spec/cloudist/job_spec.rb",
    "spec/cloudist/payload_spec.rb",
    "spec/cloudist/request_spec.rb",
    "spec/cloudist_spec.rb",
    "spec/core_ext/string_spec.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<amqp>, [">= 0"])
      s.add_runtime_dependency(%q<json>, [">= 0"])
      s.add_runtime_dependency(%q<activesupport>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_development_dependency(%q<moqueue>, [">= 0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<reek>, ["~> 1.2.8"])
      s.add_development_dependency(%q<roodi>, ["~> 2.1.0"])
    else
      s.add_dependency(%q<amqp>, [">= 0"])
      s.add_dependency(%q<json>, [">= 0"])
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_dependency(%q<moqueue>, [">= 0"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<reek>, ["~> 1.2.8"])
      s.add_dependency(%q<roodi>, ["~> 2.1.0"])
    end
  else
    s.add_dependency(%q<amqp>, [">= 0"])
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.3.0"])
    s.add_dependency(%q<moqueue>, [">= 0"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<reek>, ["~> 1.2.8"])
    s.add_dependency(%q<roodi>, ["~> 2.1.0"])
  end
end

