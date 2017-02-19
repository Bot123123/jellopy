require 'fiber'


def async(obj)

  def wrapper(func, *args)
    local_fiber = Fiber.new do
      func.call(*args)
    end
    local_fiber
  end
  if instance_of?Object
    original_fn = method(obj)
    define_method(obj) { |*args| wrapper(original_fn, *args) }
  elsif instance_of?Class
     if self.methods.include?obj
       original_fn = self.method(obj)
     elsif self.instance_methods.include?obj
       raise Exception 'Instance methods are not supported. Please use class methods.'
     else
       raise Exception
     end
     define_method(obj) { |*args| wrapper(original_fn, *args) }
   end
  1
end