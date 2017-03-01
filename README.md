# jellopy - Ruby async/await syntax      ![Jellopy] (https://i.imgur.com/7sGAV1k.png)
![Build](https://travis-ci.org/Bot123123/jellopy.svg?branch=master)
```
gem install jellopy
```

*Inspired by [Python 3.5 (PEP-0492)](https://www.python.org/dev/peps/pep-0492/)*

Note that await has to be used only in functions with the async keyword.


```
require_relative 'event_loop'
require_relative 'async'
require_relative 'await'
require_relative 'asleep'

$eloop = EventLoop.new

async def test1
  puts 'test1 before sleep'
  asleep 10
  puts 'test1 after sleep'
end

async def test3
  puts 'test3 before sleep'
  asleep 2
  puts 'test3 after sleep'
end

async def test2
  puts 'test2 before await'
  await(test1)
  puts 'test2 after await'
end


$eloop.create_task(test2)
$eloop.create_task(test3)
$eloop.start
```

Output:
```
test2 before await
test3 before sleep
test1 before sleep
test3 after sleep
test1 after sleep
test2 after await
```
