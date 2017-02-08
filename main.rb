require_relative 'event_loop'
require_relative 'async'
require_relative 'await'

async def test1
        sleep(5)
end


async def test2(p1, p2)
  puts "huiak huiak i v production #{p1}, #{p2}"
  Fiber.yield
  await(test1)
  puts 'Finish'
end

a = test2('param1', 'param2')
a.resume
a.resume
a.resume