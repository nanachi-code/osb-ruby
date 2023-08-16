# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = "osb"
  s.version = "1.0.0"
  s.authors = "Dinh Vu"
  s.email = "dinhvu2509@gmail.com"

  s.summary = "osu! storyboard framework"
  s.description = "A simple framework for building osu! storyboard."
  s.license = "MIT"
  s.homepage = "https://github.com/nanachi-code/osb-ruby"

  s.files = Dir["lib/**/*.rb"]
  s.bindir = "exe"
  s.require_paths = ["lib"]
end
