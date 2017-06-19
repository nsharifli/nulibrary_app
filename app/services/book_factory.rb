module BookFactory
  extend self

  def create(isbn:, quantity:)
    title = GoogleBooksAdapter.find_title(isbn)
    if title.nil?
      return false
    else
      author = GoogleBooksAdapter.find_author(isbn)
      description = GoogleBooksAdapter.find_description(isbn)
      image = GoogleBooksAdapter.find_image_link(isbn) || "http://via.placeholder.com/350x150"
      book = Book.new(isbn: isbn, title: title, author: author, description: description, image: image)
      inventory = Inventory.new(total_quantity: quantity, current_quantity: quantity)
      book.inventory = inventory
      book.save
    end
  end
end