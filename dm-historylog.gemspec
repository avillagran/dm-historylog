# encoding: utf-8
$:.push File.expand_path("../lib", __FILE__)
require "dm-historylog/version"

Gem::Specification.new do |s|

  s.name        = "dm-historylog"
  s.version     = Datamapper::Historylog::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Andrés Villagrán"]
  s.email       = ["andres@villagranquiroz.com"]
  s.homepage    = "http://github.com/avillagran/dm-historylog"
  
  s.summary     = %q{dm-historylog is history manager for Rails 3 and DataMapper}
  s.description = %q{Use with datamapper and Ruby on Rails 3}

  s.files         = Dir["{lib}/**/*"]
  #s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency('rails',   '>= 3.0.0')
  s.add_dependency('dm-core', '>= 1.0.0'    )
    #s.add_dependency('will_paginate', '>= 2.3.15')
  #s.add_dependency('meta_search',   '>= 1.0.1')
  
    #s.add_development_dependency('shoulda', '>= 2.11.3')
    #s.add_development_dependency('sqlite3-ruby', '>= 1.3.3')
    #s.add_development_dependency('capybara', '>= 0.4.1')
    #s.add_development_dependency('selenium-webdriver', '>= 0.1.3')
    
end
