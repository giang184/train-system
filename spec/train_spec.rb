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

  describe('#==') do
    it("is the same train if it has the same attributes as another train") do
      train1 = Train.new({:name => "Choo Choo", :id => nil})
      train1.save()
      train2 = Train.new({:name => "Choo Choo", :id => nil})
      train2.save()
      expect(train1).to(eq(train2))
    end
  end

  describe('.find') do
    it("finds an a train by id") do
      train1 = Train.new({:name => "Choo Choo", :id => nil})
      train1.save()
      train2 = Train.new({:name => "Blue", :id => nil})
      train2.save()
      expect(Train.find(train1.id)).to(eq(train1))
    end
  end

  describe('#update') do
    it("updates an train by id") do
      train1 = Train.new({:name => "Choo Choo", :id => nil})
      train1.save()
      train1.update("Cha Cha")
      expect(train1.name).to(eq("Cha Cha"))
    end
  end

  describe('#cities') do
    it("returns a train's cities") do
      train1 = Train.new({:name => "Choo Hoo", :id => nil})
      train1.save()
      city1 = City.new({:name => "Phoenix", :id => nil})
      city1.save()
      city2 = City.new({:name => "LA", :id => nil})
      city2.save()

      DB.exec("INSERT INTO cities_trains (train_id, city_id) VALUES (#{train1.id.to_i}, #{city1.id.to_i});")
      DB.exec("INSERT INTO cities_trains (train_id, city_id) VALUES (#{train1.id.to_i}, #{city2.id.to_i});")
      expect(train1.cities).to(eq(["Phoenix", "LA"]))
    end
  end
  
end