require 'fiber'

def await(obj)
  Fiber.yield
  puts 'await resume'
end
