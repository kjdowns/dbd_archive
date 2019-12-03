require 'bundler'
Bundler.require

module DBDArchive
  VERSION = "0.1.0"
end

require 'open-uri'
require_all 'lib'