class Bill < ApplicationRecord
  belongs_to :employee

  enum bill_type: { food: 0, travel: 1, others: 2 }
  enum status: { pending: 0, approved: 1, rejected: 2 }

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :bill_type, presence: true

  # Set default value for status
  after_initialize :set_default_status, if: :new_record?

  private

  def set_default_status
    self.status ||= :pending
  end
end
