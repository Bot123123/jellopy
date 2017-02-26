class AsyncClass

  attr_accessor :calls

  def initialize
    self.calls = []
  end

  async def instance_method_without_params
    @calls << {:time => Time.now, :method => 'instance_method_without_params'}
  end

  async def instance_method_with_params (*params)
    @calls << {:time => Time.now, :method => 'instance_method_with_one_param', :params => params}
  end

  async def self.class_method_with_params (*params)
    @calls << {:time => Time.now, :method => 'class_method_with_params', :params => params}
  end

  async def self.class_method_without_params
    @calls << {:time => Time.now, :method => 'class_method_without_params'}
  end

  def self.class_method_not_async
    @calls << {:time => Time.now, :method => 'class_method_not_async'}
  end


end