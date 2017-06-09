module GoogleBooksAdapter
  def self.find_title(isbn)
    GoogleBooks.search("isbn:#{isbn}").first.title
  end

  def self.find_description(isbn)
    GoogleBooks.search("isbn:#{isbn}").first.description
  end
end