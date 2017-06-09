module GoogleBooksAdapter
  def self.find_title(isbn)
    book(isbn).title
  end

  def self.find_description(isbn)
    book(isbn).description
  end

  def self.find_author(isbn)
    book(isbn).authors
  end

  def self.find_image_link(isbn)
    book(isbn).image_link
  end

  private
  def self.book(isbn)
    GoogleBooks.search("isbn:#{isbn}").first
  end

end