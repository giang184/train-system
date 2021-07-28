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

  describe('.all') do
    it("returns a list of all cities") do
      city1 = City.new({:name => "Portland", :train_id => @train.id, :id => nil})
      city1.save()
      city2 = City.new({:name => "LA", :train_id => @train.id, :id => nil})
      city2.save()
      expect(City.all).to(eq([city1, city2]))
    end
  end

  describe('.clear') do
    it("clears all cities") do
      city1 = City.new({:name => "Portland", :train_id => @train.id, :id => nil})
      city1.save()
      city2 = City.new({:name => "LA", :train_id => @train.id, :id => nil})
      city2.save()
      City.clear()
      expect(City.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves a city") do
      city1 = City.new({:name => "Portland", :train_id => @train.id, :id => nil})
      city1.save()
      expect(City.all).to(eq([city1]))
    end
  end

  describe('.find') do
    it("finds a city by id") do
      city1 = City.new({:name => "Portland", :train_id => @train.id, :id => nil})
      city1.save()
      city2 = City.new({:name => "LA", :train_id => @train.id, :id => nil})
      city2.save()
      expect(City.find(city1.id)).to(eq(city1))
    end
  end

end