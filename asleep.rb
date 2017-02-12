require 'fiber'

def asleep(sec)
  $eloop.call_later(Fiber.current, sec, $eloop.item[:callback])
  Fiber.yield
end