require 'spec_helper'

describe AsyncClass do

  describe 'instantiation' do
    let!(:async_class) { build(:async_class) }

    it 'instantiates a class without errors' do
      expect(async_class.class.name).to eq("AsyncClass")
    end

    it 'instantiates a class with corresponding class and instance methods' do
      expect(async_class.methods).to include(:instance_method_without_params,
                                             :instance_method_with_params)

      expect(async_class.methods).not_to include(:class_method_with_params,
                                                 :class_method_without_params,
                                                 :class_method_not_async)

      expect(async_class.class.methods).to include(:class_method_with_params,
                                                   :class_method_without_params,
                                                   :class_method_not_async)

      expect(async_class.class.methods).not_to include(:instance_method_without_params,
                                                       :instance_method_with_params)
    end

  end

end