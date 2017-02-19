require_relative 'event_loop'
require_relative 'async'
require_relative 'await'
require_relative 'asleep'

$eloop = EventLoop.new

# async def test1
#   puts 'test1 before sleep'
#   asleep 5
#   puts 'test1 after sleep'
# end
#
class B
  def test1
    puts 'test1 before sleep'
    #asleep 5
    puts 'test1 after sleep'
  end
end


b = B.new
b.test1
# async def test3
#   puts 'test3 before sleep'
#   asleep 2
#   puts 'test3 after sleep'
# end
#
# async def test2
#   puts 'test2 before await'
#   await(test1)
#   puts 'test2 after await'
# end


# TODO: async with args
#
#$eloop.create_task(test1)
# $eloop.create_task(test3)
#$eloop.start
1