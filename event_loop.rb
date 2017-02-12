require 'time'
require 'fiber'


class EventLoop

  attr_accessor :item
  def initialize
    @queue = []
    @item = {}
  end


  def create_task(fn)
    self.call_later(fn, 0)
  end

  def call_later(fn, timeout, callback=nil)
    @queue << {:fn => fn, :time => Time.now.to_f + timeout, :callback => callback}
  end

  def start
    while @queue.size > 0
      @queue.sort_by!{|i| i[:time].to_i}
      @item = @queue[0]
      ctime = Time.now.to_f
      if ctime >= @item[:time]
        @queue.delete_at 0
        @item[:fn].resume
        self.call_later(@item[:callback], 0) if @item[:callback] and not @item[:fn].alive?
      end

    end
  end

  def stop

  end

end