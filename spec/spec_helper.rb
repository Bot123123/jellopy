require 'rubygems'
require 'factory_girl'
require 'rspec'
require_relative '../lib/event_loop'
require_relative '../lib/async'
require_relative '../lib/await'
require_relative '../lib/asleep'
require_relative 'async_class'
require_relative 'factories/async_class'
require_relative 'factories/event_loop'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end