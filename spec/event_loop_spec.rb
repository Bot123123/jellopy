require 'spec_helper'

describe EventLoop do

  let!(:event_loop) { build(:event_loop) }
  let!(:async_class) { build(:async_class) }

  describe 'instantiation' do
    it { expect(event_loop.class.name).to eq("EventLoop") }
    it { expect(async_class.class.name).to eq("AsyncClass") }
    it { expect(async_class.calls).to eq([]) }
  end

  describe 'create_task and start loop' do
    it 'create and start 3 tasks' do
      event_loop.create_task(async_class.instance_method_without_params)
      event_loop.create_task(async_class.instance_method_without_params)
      event_loop.create_task(async_class.instance_method_without_params)
      event_loop.start

      expect(async_class.calls.map{|i| i[:method]}).to eq(['instance_method_without_params'] * 3)
    end
  end

  describe 'await' do
    it 'await for instance method from instance method' do
      event_loop = build(:event_loop)
      async_class = build(:async_class)
      $eloop = event_loop


      class << async_class
        async def await_for_instance_method
          self.calls << {:time => Time.now, :method => 'await_for_instance_method'}
          await self.instance_method_without_params
          self.calls << {:time => Time.now, :method => 'after await'}
        end
      end

      event_loop.create_task(async_class.await_for_instance_method)
      event_loop.start

      expect(async_class.calls.map{|i| i[:method]}).to eq(['await_for_instance_method',
                                                           'instance_method_without_params',
                                                           'after await'])
    end

    it 'asleep positive' do
      event_loop = build(:event_loop)
      async_class = build(:async_class)
      $eloop = event_loop


      class << async_class
        async def await_for_instance_method
          self.calls << {:time => Time.now, :method => 'await_for_instance_method'}
          asleep 0.2
          await self.instance_method_without_params
          self.calls << {:time => Time.now, :method => 'after await'}
        end
      end

      event_loop.create_task(async_class.await_for_instance_method)
      event_loop.start

      expect(async_class.calls.map{|i| i[:method]}).to eq(['await_for_instance_method',
                                                           'instance_method_without_params',
                                                           'after await'])

      expect(async_class.calls[1][:time] - async_class.calls[0][:time]).to be_between(0.2, 0.3).inclusive
    end

    it 'zero-asleep' do
      event_loop = build(:event_loop)
      async_class = build(:async_class)
      $eloop = event_loop


      class << async_class
        async def first_method
          self.calls << {:time => Time.now, :method => 'first_method before asleep'}
          asleep 0
          self.calls << {:time => Time.now, :method => 'first_method after asleep'}
        end
      end

      event_loop.create_task(async_class.first_method)
      event_loop.create_task(async_class.instance_method_without_params)
      event_loop.start

      # first method with zero-asleep-delay will finish after second method
      expect(async_class.calls.map{|i| i[:method]}).to eq(['first_method before asleep',
                                                           'instance_method_without_params',
                                                           'first_method after asleep'])

    end

    describe 'add_task alias' do
      it 'await for instance method from instance method' do
        event_loop = build(:event_loop)
        async_class = build(:async_class)
        $eloop = event_loop


        class << async_class
          async def await_for_instance_method
            self.calls << {:time => Time.now, :method => 'await_for_instance_method'}
            await self.instance_method_without_params
            self.calls << {:time => Time.now, :method => 'after await'}
          end
        end

        event_loop.add_task(async_class.await_for_instance_method)
        event_loop.start

        expect(async_class.calls.map{|i| i[:method]}).to eq(['await_for_instance_method',
                                                             'instance_method_without_params',
                                                             'after await'])
      end
    end
  end
end