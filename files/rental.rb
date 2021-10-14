class Rental
  attr_accessor :date
  attr_reader :book

  def initialize(date, book, person)
    @date = date
    @person = person
    @book = book
    book.rentals << self
    person.rentals << self
  end
end
