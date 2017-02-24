def async(obj)

  def wrapper(func, *args)
    local_fiber = Fiber.new do
      if func.instance_of?UnboundMethod
        # TODO: write unit tests with corner cases for this line
        func = func.bind(self)
      end
      func.call(*args)
    end
    local_fiber
  end

  if instance_of?Object
    original_fn = method(obj)
    define_method(obj) { |*args| wrapper(original_fn, *args) }
  elsif instance_of?Class

    # handling class methods
    if self.methods.include?obj
      original_fn = self.method(obj)
      class_eval {define_method(:a_class_method) { |*args| wrapper(original_fn, *args) }}

    # handling instance methods
    elsif self.instance_methods.include?obj
      original_fn = instance_method(obj)
      define_method(obj) { |*args| wrapper(original_fn, *args) }

    else
      raise 'Unhandled case'
    end

   end
end