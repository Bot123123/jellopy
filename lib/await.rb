def await(wait_for_obj)
  $eloop.call_later(wait_for_obj, 0, Fiber.current)
  Fiber.yield
end
