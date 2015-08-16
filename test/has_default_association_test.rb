require_relative './test_helper'

# The required models are defined inline here for clarity.

class Book < ActiveRecord::Base
  include HasDefaultAssociation
  
  belongs_to :author, class_name: "Person"
  has_default_association(:author)

  has_one :summary
  has_default_association(:summary) do |book|
    Summary.new(text: "'#{book.name}' is just swell!")
  end
  
  has_many :reviews
end

class Summary < ActiveRecord::Base
  include HasDefaultAssociation
  
  belongs_to :book
  has_default_association :book
end

class Review < ActiveRecord::Base
  include HasDefaultAssociation
  
  belongs_to :book
  belongs_to :person
  
  has_default_association :book, :person
end

class Person < ActiveRecord::Base
  DEFAULT_BOOK_NAMES = ["First", "Second", "Third"]
  include HasDefaultAssociation
  
  has_many :books
  has_default_association :books do |person|
    DEFAULT_BOOK_NAMES.map{|n| Book.new(name: n) }
  end
end



class HasDefaultAssociationTest < ActiveSupport::TestCase  
  
  test "builds default models" do
    book = Summary.new.book
    
    assert_kind_of Book, book
    assert !book.persisted?
  end
  
  test "infers correct model class" do
    author = Book.new.author
    
    assert_kind_of Person, author
  end
  
  test "builds default models with custom blocks" do
    name = "Writing Plugins For Fun and the Other Thing"
    book = Book.new(name: name)
    
    summary = book.summary
    
    assert_kind_of Summary, summary
    assert_includes summary.text, name
  end
  
  test "does not overwrite newly set associations" do
    book = Book.new
    author = Person.new
    book.author = author
    
    assert book.author === author
  end
  
  test "loads saved associations" do
    author = Person.create!
    book = Book.create!(author: author)
    
    assert book.author === author
  end
  
  test "supports one to many relations with custom block" do
    person = Person.new
    
    default_book_names = person.books.map{|b| b.name}
    assert_equal Person::DEFAULT_BOOK_NAMES, default_book_names
  end
  
  test "multiple relations can be declared at once" do
    review = Review.new

    book   = review.book
    person = review.person
        
    assert_kind_of Book, book
    assert_kind_of Person, person
  end
  
end
