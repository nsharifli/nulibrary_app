module BookDeleteService
  extend self
  def delete(book_id)
    ActiveRecord::Base.transaction do
      begin
        Book.destroy(book_id)
      rescue
        raise ActiveRecord::Rollback
      end
    end
  end
end
