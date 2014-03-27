require 'pry'
require 'minitest/autorun'
require 'turn/autorun'

require 'dotenv'
Dotenv.load

require 'ruby_meetup'
RubyMeetup::ApiKeyClient.key = ENV['MEETUP_API_KEY']

require 'webmock/minitest'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :webmock
end
