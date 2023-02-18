# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

require "decidim/slider/version"

Gem::Specification.new do |s|
  s.version = Decidim::Slider.version
  s.authors = [""]
  s.email = [""]
  s.license = "AGPL-3.0"
  s.homepage = "https://github.com/decidim/decidim-module-slider"
  s.required_ruby_version = ">= 2.7"

  s.name = "decidim-slider"
  s.summary = "A decidim slider module"
  s.description = "A Slider component for Decidim's homepage."

  s.files = Dir["{app,config,lib}/**/*", "LICENSE-AGPLv3.txt", "Rakefile", "README.md"]

  s.add_dependency "decidim-core", Decidim::Slider.version
end
