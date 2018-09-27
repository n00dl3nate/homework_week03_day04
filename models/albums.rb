require("pg")
require_relative("../db/sql_runner.rb")


class Albums

  attr_accessor(:title, :genre, :artist_id)
  attr_reader(:id)

  def initialize(options)

    @title     = options["title"]
    @genre     = options["genre"]
    @id        = options["id"].to_i
    @artist_id = options["artist_id"].to_i

  end

  def save

    sql = "INSERT INTO albums (
          artist_id,
          title,
          genre)
          VALUES ($1,$2,$3)
          RETURNING id;"

          values = [@artist_id,@title,@genre]

          result = SqlRunner.run(sql, values)

          result_hash = result[0]
          string_id = result_hash["id"]
          id = string_id.to_i()
          @id = id
  end

  def self.all()
    sql = "SELECT * FROM albums;"
    order_hashes = SqlRunner.run(sql)

    order_objects = order_hashes.map do |order_hash|
      Albums.new(order_hash)
    end

    return order_objects
  end

  def artist()

  sql = "SELECT * FROM artists
  WHERE id = $1;"

  results = SqlRunner.run(sql,[@artist_id])

  artist_hash = results[0]

  artist = Artists.new(artist_hash)

  return artist


  end


end
