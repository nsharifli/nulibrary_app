module GoogleBooksAdapter
  def self.find_title(isbn)
    GoogleBooks.search("isbn:#{isbn}").first.title
  end
end