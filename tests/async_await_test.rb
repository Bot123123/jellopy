require "minitest/autorun"
require_relative '../event_loop'
require_relative '../async'
require_relative '../await'
require_relative '../asleep'

$eloop = EventLoop.new

class TestClassMethods < Minitest::Test

  @@storage = []

  def setup
    @@storage = []
  end

  async def self.some_async_function_0
    @@storage << 0
  end

  async def self.some_async_function_1
    @@storage  << 1
  end

  # TODO: add case with await inside class method
  def test_positive
    $eloop.create_task(self.some_async_function_0)
    $eloop.create_task(self.some_async_function_1)
    $eloop.start
    assert_equal([0,1], self.class.class_variable_get(:@@storage))
  end

end

class TestInstanceMethods < Minitest::Test

  @storage = []

  def setup
    @storage = []
  end

  async def some_async_function_0
    @storage << 0
    await(self.some_async_function_1)
  end

  async def some_async_function_1
    @storage  << 1
  end

  def test_positive
    $eloop.create_task(self.some_async_function_0)
    $eloop.create_task(self.some_async_function_1)
    $eloop.start
    assert_equal([0,1,1], @storage)
  end

end

class TestAsleep < Minitest::Test

  @storage = []

  def setup
    @storage = []
  end

  async def some_async_function_0
    asleep(0.2)
    @storage << 0
  end

  async def some_async_function_1
    @storage  << 1
  end

  def test_positive
    $eloop.create_task(self.some_async_function_0)
    $eloop.create_task(self.some_async_function_1)
    $eloop.start
    assert_equal([1,0], @storage)
  end

end
