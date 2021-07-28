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

  # describe('#delete') do
  #   it("deletes all trains belonging to a deleted album") do
  #     album = Album.new({:name => "A Love Supreme", :id => nil})
  #     album.save()
  #     song = Song.new({:name => "Naima", :album_id => album.id, :id => nil})
  #     song.save()
  #     album.delete()
  #     expect(Song.find(song.id)).to(eq(nil))
  #   end
  # end

  # describe('#songs') do
  #   it("returns an album's songs") do
  #     album = Album.new({:name => "A Love Supreme", :id => nil})
  #     album.save()
  #     song = Song.new({:name => "Naima", :album_id => album.id, :id => nil})
  #     song.save()
  #     song2 = Song.new({:name => "Cousin Mary", :album_id => album.id, :id => nil})
  #     song2.save()
  #     expect(album.songs).to(eq([song, song2]))
  #   end
  # end
  
end