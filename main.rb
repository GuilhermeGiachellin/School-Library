require_relative './files/student'
require_relative './files/teacher'
require_relative './files/book'
require_relative './files/rental'
require_relative './files/person'

class App
  def initialize
    @book = []
    @people = []
    @rental = []
  end

  def run
    menu = ["\nPlease choose an option by entering a number", '1 - List all books', '2 - List all people',
            '3 - Create a person', '4 - Create a book', '5 - Create a rental', '6 - List all rentals for a given person id',
            '7 - Exit']
    menu.each do |options|
      puts options
    end
    option = gets.chomp.to_i
    check_option(option)
  end

  def create_teachers
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Specialization: '
    specialization = gets.chomp    
    @people << Teacher.new(age, name, true, specialization)
    puts "Person created successfully"
    run
  end

  def create_students
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp      
    print 'Has parente permission? [Y/N]: '  
    parent_permission = gets.chomp
    if parent_permission == 'n'
        parent_permission = false
    end
    @people << Student.new(age, name, parent_permission)
    puts "Person created successfully"
    run
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    option = gets.chomp.to_i
    if option == 1
      create_students
    elsif option == 2
      create_teachers
    else
      p 'Invalid number, type again!'
      run
    end    
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    @book << Book.new(title, author)
    puts 'New book added!'
    run
  end

  def create_rental    
    puts "\nSelect a book from the following list by number: "    
    @book.each_with_index do |show, index|       
        puts "#{index}) Title: #{show.title}  Author: #{show.author}"    
    end      
    book_rented = gets.chomp.to_i
    book_rented = @book[book_rented]
    puts "\nSelect a person from the following list by number (not ID): "
    @people.each_with_index do |show, index| 
        puts "#{index}) [#{show.class}] Name: #{show.name}, ID: #{show.id}, Age: #{show.age}"       
    end
    renter = gets.chomp.to_i
    renter = @people[renter]
    print "\nDate: "
    date = gets.chomp
    Rental.new(date, book_rented, renter)
    puts "Rental created successfully"
    run
  end

  def show_books
    @book.each do |show| 
        puts "Title: #{show.title}  Author: #{show.author}"        
    end
    run
  end

  def show_people
    @people.each do |show| 
        puts "[#{show.class}] Name: #{show.name}, ID: #{show.id}, Age: #{show.age}"        
    end
    run
  end

  def rental_id
    print "ID of person: "
    id = gets.chomp.to_i
    @people.each do |person|
        next unless id == person.id
        target = person.rentals
        puts "\nRentals: "
        target.each do |rented|            
            puts "Date: #{rented.date}, Book: #{rented.book.title} by #{rented.book.author}"
        end
    end
    run
  end  

  def check_option(option)
    case option
    when 1
      show_books
    when 2
      show_people
    when 3
      create_person
    when 4
      create_book
    when 5
      create_rental
    when 6
      rental_id
    when 7
      puts "--Good Bye--"
      exit(true)
    end
  end
end

def main
  main = App.new
  main.run
end
puts "Welcome to School Library App!\n"
main
