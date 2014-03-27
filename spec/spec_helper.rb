require 'pry'
require 'minitest/autorun'
require 'turn/autorun'

require 'dotenv'
Dotenv.load

require 'webmock/minitest'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :webmock
end
