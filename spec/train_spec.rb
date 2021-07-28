require('spec_helper')

describe '#Train' do

  describe('.all') do
    it("returns an empty array when there are no trains") do
      expect(Train.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves two trains") do
      train1 = Train.new({:name => "Choo Choo", :id => nil})
      train1.save()
      train2 = Train.new({:name => "Blue", :id => nil})
      train2.save()
      expect(Train.all).to(eq([train1, train2]))
    end
  end

  describe('.clear') do
    it("clears all trains") do
      train1 = Train.new({:name => "Choo Choo", :id => nil})
      train1.save()
      train2 = Train.new({:name => "Blue", :id => nil})
      train2.save()
      Train.clear
      expect(Train.all).to(eq([]))
    end
  end
  
end