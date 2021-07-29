class City
  attr_reader :id
  attr_accessor :name

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def ==(city_to_compare)
    if city_to_compare != nil
      (self.name() == city_to_compare.name())
    else
      false
    end
  end

  def self.all
    returned_cities = DB.exec("SELECT * FROM cities;")
    cities = []
    returned_cities.each() do |c|
      name = c.fetch("name")
      id = c.fetch("id").to_i
      cities.push(City.new({:name => name, :id => id}))
    end
    cities
  end

  def save
    result = DB.exec("INSERT INTO cities (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def self.find(id)
    city = DB.exec("SELECT * FROM cities WHERE id = #{id};").first
    if city
      name = city.fetch("name")
      id = city.fetch("id").to_i
      City.new({:name => name, :id => id})
    else
      nil
    end
  end

  def update(attributes)
    if (attributes.has_key?(:name)) && (attributes.fetch(:name) != nil)
      @name = attributes.fetch(:name)
      DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = #{@id};")
    elsif (attributes.has_key?(:train_name)) && (attributes.fetch(:train_name) != nil)
      train_name = attributes.fetch(:train_name)
      train = DB.exec("SELECT * FROM trains WHERE lower(name)='#{train_name.downcase}';").first
      if album != nil
        DB.exec("INSERT INTO cities_trains (train_id, city_id) VALUES (#{train["id"].to_i}, #{@id});")
      end
    end
  end

  def delete
    DB.exec("DELETE FROM cities_trains WHERE city_id = #{@id};")
    DB.exec("DELETE FROM cities WHERE id = #{@id};")
  end

  def self.clear
    DB.exec("DELETE FROM cities *;")
  end

  def self.find_by_train(trn_id)
    cities = []
    returned_cities = DB.exec("SELECT * FROM cities_trains WHERE train_id = #{trn_id};")
    returned_cities.each() do |city|
      city_name = DB.exec("SELECT name FROM cities WHERE id = #{city.fetch("city_id")};").first()
      city_id = DB.exec("SELECT id FROM cities WHERE id = #{city.fetch("city_id")};").first()
      cities.push([city_name, city_id])
    end
    cities
  end

  def trains
    trains = []
    results = DB.exec("SELECT train_id FROM cities_trains WHERE city_id = #{@id};")
    results.each() do |result|
      train_id = result.fetch("train_id").to_i()
      train = DB.exec("SELECT * FROM trains WHERE id = #{train_id};")
      name = train.first().fetch("name")
      trains.push(Train.new({ :name => name, :id => train_id }))
    end
    trains
  end

  def link(t_id, b_time)
    DB.exec("INSERT INTO cities_trains (train_id, city_id, boarding_time) VALUES (#{t_id.to_i}, #{@id.to_i}, '#{b_time.to_s}');")
  end

  def boarding (train_id)
    DB.exec("SELECT boarding_time FROM cities_trains WHERE city_id = #{@id.to_i} AND train_id = #{train_id.to_i};").first
  end
end