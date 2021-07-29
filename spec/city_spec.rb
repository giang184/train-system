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
  
  describe('#update') do
    it("updates a city by id") do
      city1 = City.new({:name => "Portland", :id => nil})
      city1.save()
      city1.update({:name => "Seattle"})
      expect(city1.name).to(eq("Seattle"))
    end
  end

  describe('#delete') do
    it("deletes a city by id") do
      city1 = City.new({:name => "Portland", :id => nil})
      city1.save()
      city2 = City.new({:name => "LA", :id => nil})
      city2.save()
      city1.delete()
      expect(City.all).to(eq([city2]))
    end
  end

  describe('.find_by_train') do
    it("finds cities for a train") do
      train1 = Train.new({:name => "Hoo Hoo", :id => nil})
      train1.save
      city1 = City.new({:name => "Portland", :id => nil})
      city1.save()
      DB.exec("INSERT INTO cities_trains (train_id, city_id) VALUES (#{train1.id.to_i}, #{city1.id.to_i});")
      expect(City.find_by_train(train1.id)).to(eq([city1.name]))
    end
  end

  describe('#trains') do
    it("finds the train a city belongs to") do
      city = City.new({:name => "LA", :id => nil})
      city.save()
      DB.exec("INSERT INTO cities_trains (train_id, city_id) VALUES (#{@train.id.to_i}, #{city.id.to_i});")
      expect(city.trains()[0]).to(eq(@train))
    end
  end
end