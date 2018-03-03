class BookDeleteService
  attr_reader :user, :book

  def initialize(user, book)
    @user = user
    @book = book
  end

  def delete
    errors = validate_is_deletable

    destroy if errors.empty?

    errors
  end



  private

  def validate_is_deletable
    []
      .concat([book.nil? ? "Book does not exist in library" : nil])
      .concat([user.admin? ? nil : "You do not have a permission to delete a book"])
      .concat([book.transactions.exists? ? "Book cannot be deleted, since it is checked out" : nil])
      .compact
  end

  def destroy
    ActiveRecord::Base.transaction do
      begin
        Book.destroy(book)
      rescue
        raise ActiveRecord::Rollback
      end
    end
  end
end
