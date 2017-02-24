require 'rubygems'
require 'factory_girl'
require 'rspec'
require_relative '../lib/event_loop'
require_relative '../lib/async'
require_relative '../lib/await'
require_relative '../lib/asleep'
require_relative 'models/async_class'
require_relative 'factories/async_class'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end