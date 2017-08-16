require("pry-byebug")
require_relative("../models/artist")
require_relative("../models/album")

Album.delete_all
Artist.delete_all

artist1 = Artist.new({"name" => "The Beatles"})
artist2 = Artist.new({"name" => "Oasis"})
artist3 = Artist.new({"name" => "Blur"})
artist1.save
artist2.save
artist3.save

album1 = Album.new({
  "artist_id" => artist1.id,
  "title" => "Revolver",
  "genre" => "rock"
  })

album2 = Album.new({
  "artist_id" => artist1.id,
  "title" => "A Hard Day's Night",
  "genre" => "rock"
  })

album3 = Album.new({
  "artist_id" => artist2.id,
  "title" => "Definitely Maybe",
  "genre" => "rock"
  })

album4 = Album.new({
  "artist_id" => artist3.id,
  "title" => "The Magic Whip",
  "genre" => "pop"
  })

album1.save
album2.save
album3.save
album4.save

binding.pry
nil
