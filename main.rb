require_relative 'event_loop'
require_relative 'async'
require_relative 'await'
require_relative 'asleep'


async def test1
  puts 'test1 before sleep'
  asleep 5
  puts 'test1 after sleep'
end

$eloop = EventLoop.new

async def test3
  puts 'test3 before sleep'
  asleep 1
  puts 'test3 after sleep'
end

async def test2
  puts 'test2 before await'
  await(test1)
  puts 'test2 after await'
end


$eloop.create_task(test2)
$eloop.start