require_relative("../db/sqlrunner")

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize (options)
    @id = (options)[id].to_i if options['id']
    @customer_id = options['customer_id']
    @film_id = options['film_id']
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id) VALUES ($1, $2) RETURNING id"
    values = [@customer_id, @film_id]
    ticket = SqlRunner.run( sql, values ).first
    @id = ticket['id'].to_i
  end

  def update()
    sql = "UPDATE tickets SET (customer_id, film_id) = ($1, $2) WHERE id = $3"
    values = [@customer_id, @film_id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE * FROM tickets where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end


  def films()
    sql = "SELECT * FROM films WHERE id = $1"
    values = [@film_id]
    film = SqlRunner.run(sql, values).first
    return Film.new(film)
  end

  def customers()
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [@customer_id]
    customer = SqlRunner.run(sql, values).first
    return Customer.new(customer)
  end


  def self.all()
    sql = "SELECT * FROM tickets"
    data = SqlRunner.run(sql)
    return data.map {|ticket| Ticket.new(ticket)}
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end


end
