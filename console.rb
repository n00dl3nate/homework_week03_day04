require_relative("./models/artist.rb")
require_relative("./models/albums.rb")
require("pry")


artist1 = Artists.new({
  "name" => "Linkin Park"
  })

artist2 = Artists.new({
  "name" => "Micheal Jackson"
  })


artist1.save

album1 = Albums.new({
  "title" => "Hybrid Theory",
  "genre" => "Alternative",
  "artist_id" => artist1.id
  })

album2 = Albums.new({
  "title" => "Bad",
  "genre" => "R&B",
  "artist_id" => artist2.id
  })

album1.save
binding.pry
nil
