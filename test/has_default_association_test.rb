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
end

class Summary < ActiveRecord::Base
  include HasDefaultAssociation
  
  belongs_to :book
  has_default_association :book
end

class Person < ActiveRecord::Base
  include HasDefaultAssociation
  
  has_many :books
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
  
  test "supports custom default blocks" do
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
  
end
