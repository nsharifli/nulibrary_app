module GoogleBooksAdapter
  def self.find_title(isbn)
    book(isbn).nil? ? nil : book(isbn).title
  end

  def self.find_description(isbn)
    book(isbn).nil? ? nil : book(isbn).description
  end

  def self.find_author(isbn)
    book(isbn).nil? ? nil : book(isbn).authors
  end

  def self.find_image_link(isbn)
    book(isbn).nil? ? nil : book(isbn).image_link
  end

  private
  def self.book(isbn)
    GoogleBooks.search("isbn:#{isbn}").first
  end
end