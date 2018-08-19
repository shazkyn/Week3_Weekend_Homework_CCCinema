require_relative("../db/sqlrunner")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize (options)
    @id = (options)[id].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    films = SqlRunner.run( sql, values ).first
    @id = films['id'].to_i
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id ]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM films where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end


  def customers()
    sql = "SELECT * FROM customers INNER JOIN tickets ON tickets.customer_id = customers.id I
    INNER JOIN films on films.id = tickets.film_id WHERE film_id = 4"
    values = [@id]
    customer_data = SqlRunner.run(sql, values)
    return Customer.map_items(customer_data)
  end

  def ticket_count()
    sql = "SELECT * FROM tickets WHERE film_id = $4"
    values = [@id]
    ticket_data = SqlRunner.run(sql, values)
    return Ticket.length
  end

  def self.all()
    sql = "SELECT * FROM films"
    film_data = SqlRunner.run(sql)
    return Film.map_items(film_data)
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def self.map_items(data)
    result = data.map{|film| Film.new(film)}
    return result
  end

end
