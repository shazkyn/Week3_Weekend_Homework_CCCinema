
require_relative('models/customers')
require_relative('models/films')
require_relative('models/tickets')


require('pry-byebug')


Customer.delete_all()
Film.delete_all()
Ticket.delete_all()



customer1 = Customer.new({'name' => 'Mrs Tiggywinkle', 'funds' => 100 })
customer1.save()
customer2 = Customer.new({'name' => 'Peter Rabbit', 'funds' => 50})
customer2.save()
customer3 = Customer.new({'name' => 'Mr Anderson', 'funds' => 35})
customer3.save()
customer4 = Customer.new({'name' => 'Jemima Puddleduck', 'funds' => 300})
customer4.save()


film1 = Film.new({'title' => 'Watership Down', 'price' => 3})
film1.save()
film2 = Film.new({'title' => 'Singing in the Rain', 'price' => 2 })
film2.save()
film3 = Film.new({'title' => 'Stagecoach', 'price' => 2})
film3.save()
film4 = Film.new({'title' => 'Grease', 'price' => 4})
film4.save()

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()
ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id})
ticket2.save()
ticket3 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film3.id})
ticket3.save()
ticket4 = Ticket.new({'customer_id' => customer4.id, 'film_id' => film4.id})
ticket4.save()
ticket5 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film4.id})
ticket5.save()

customer4.buy_ticket(film4)
customer4.save()

binding.pry
nil
