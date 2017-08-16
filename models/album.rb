require_relative("../db/sql_runner")

class Album

  attr_accessor(:title, :artist_id, :genre)
  attr_reader(:id)

  def initialize(params)
    @artist_id = params["artist_id"]
    @title = params["title"]
    @genre = params["genre"]
    @id = params['id'].to_i() if params['id']
  end

  def save
    sql = "
    INSERT INTO albums (
        artist_id, title, genre
      ) VALUES (
        $1, $2, $3
      )
      RETURNING *;
    "
    values = [@artist_id, @title, @genre]
    results_array = SqlRunner.run(sql, values)
    saved_albums_hash = results_array[0]
    @id = saved_albums_hash['id'].to_i()
  end

  def Album.delete_all
    sql = "DELETE FROM albums;"
    SqlRunner.run(sql)
  end


  def Album.all
    sql = "SELECT * FROM albums;"
    results = SqlRunner.run(sql)
    albums = results.map { |album_hash| Album.new(album_hash)  }
    return albums
  end

  def artist
    sql = "
    SELECT * FROM artists
    WHERE id = $1;"

    results = SqlRunner.run(sql,[@artist_id])
    artist_hash = results[0]
    artist_object = Artist.new(artist_hash)
    return artist_object
  end

end
