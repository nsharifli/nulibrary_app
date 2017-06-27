module BookHoldService
  extend self
  def hold(user:, book:)
    ActiveRecord::Base.transaction do
      begin
        add_hold_entry(user, book)
      rescue
        raise ActiveRecord::Rollback
      end
    end
  end

  private

  def add_hold_entry(user, book)
    Hold.create!(user: user, book: book, requested_at: Time.zone.now)
  end
end