class Book < ApplicationRecord
  has_one :inventory
  has_many :transactions
  # Validation
  validates :ibn, presence: true, uniqueness: true
  validate :ibn_valid_length
  validates :title, presence: true
  validates_presence_of :inventory

  def ibn_valid_length
    length = ibn.try(:length)
    if length != 10 && length != 13
      errors.add(:ibn, "Length should be either 10 or 13")
    end
  end

  def borrow(user)
    Inventory.borrow(id)
    add_borrow_entry(user)
  end

  def current_quantity
    Inventory.current_quantity(id)
  end

  def total_quantity
    Inventory.total_quantity(id)
  end

  def in_stock?
    current_quantity > 0
  end

  def return(user)
    Inventory.return(id)
    update_book_transaction(user)
  end

  def self.create_new_book(isbn, quantity)
    title = GoogleBooksAdapter.find_title(isbn)
    author = GoogleBooksAdapter.find_author(isbn)
    description = GoogleBooksAdapter.find_description(isbn)
    image = GoogleBooksAdapter.find_image_link(isbn) || "http://via.placeholder.com/350x150"
    if title.nil?
      return false
    else
      book = Book.new(ibn: isbn, title: title, author: author, description: description, image: image)
      inventory = Inventory.new(total_quantity: quantity, current_quantity: quantity)
      book.inventory = inventory
      book.save
    end
  end

  private

  def add_borrow_entry(user)
    Transaction.add_borrow_entry(user,id)
  end

  def update_book_transaction(user)
    Transaction.update_book_transaction(user, id)
  end
end
