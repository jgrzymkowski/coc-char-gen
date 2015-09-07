module SoftDeletable
  extend ActiveSupport::Concern

  def soft_delete
    self.update_attribute(:deleted_at, DateTime.now)
  end
end
