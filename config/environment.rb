require 'bundler'
Bundler.require

module DBDArchive
  VERSION = "0.1.0"
end

require 'open-uri'
require 'colorize'
require_all 'lib'