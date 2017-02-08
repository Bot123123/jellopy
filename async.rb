require 'fiber'

def async(obj)
  def wrapper(func, *args)
    local_fiber = Fiber.new do
      func.call(*args)
    end
    local_fiber
  end
  original_fn = method(obj)
  define_method(obj) { |*args| wrapper(original_fn, *args) }
end