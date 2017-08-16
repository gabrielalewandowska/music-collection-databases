require_relative("../db/sql_runner")

class Artist

  attr_accessor(:name)
  attr_reader(:id)

  def initialize(params)
    @id = params["id"].to_i if params["id"]
    @name = params["name"]
  end

  def save
    sql = "
    INSERT INTO artists (
        name
      ) VALUES (
        $1
      )
      RETURNING *;
    "
      @id = SqlRunner.run(sql, [@name])[0]['id'].to_i()
  end

  def Artist.delete_all
    sql = "DELETE FROM artists;"
    SqlRunner.run(sql)
  end


  def Artist.all
    sql = "SELECT * FROM artists;"
    results = SqlRunner.run(sql)
    artists = results.map { |artist_hash| Artist.new(artist_hash)  }
    return artists
  end

  def albums
    sql = "
      SELECT * FROM albums
      WHERE artist_id = $1;"

    results = SqlRunner.run(sql, [@id])
    albums = results.map {|result|
      Album.new(result)}
    return albums
  end

end
