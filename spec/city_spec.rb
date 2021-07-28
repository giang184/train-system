require('spec_helper')

describe '#City' do

  before(:each) do
    @train = Train.new({:name => "Choo Choo", :id => nil})
    @train.save()
  end

  describe('#==') do
    it("is the same city if it has the same attributes as another city") do
      city1 = City.new({:name => "Portland", :train_id => @train.id, :id => nil})
      city2 = City.new({:name => "Portland", :train_id => @train.id, :id => nil})
      expect(city1).to(eq(city2))
    end
  end

end