require("pg")
require_relative("../db/sql_runner.rb")

class Artists

  attr_accessor(:name)
  attr_reader(:id)


  def initialize(options)

    @name  = options["name"]
    @id    = options["id"].to_i

  end

  def save

    sql = "INSERT INTO artists (
          name)
          VALUES ($1)
          RETURNING id;"

          values = [@name]

          result = SqlRunner.run(sql, values)

          result_hash = result[0]
          string_id = result_hash["id"]
          id = string_id.to_i()
          @id = id
  end

  def self.all()
    sql = "SELECT * FROM artists;"
    order_hashes = SqlRunner.run(sql)

    order_objects = order_hashes.map do |order_hash|
      Artists.new(order_hash)
    end

    return order_objects

  end

  def albums()
  sql = "SELECT * FROM albums
         WHERE artist_id = $1;"

   results = SqlRunner.run(sql,[@id])

   orders = results.map do |order_hash|
     Albums.new(order_hash)
   end

   return orders
end

end
