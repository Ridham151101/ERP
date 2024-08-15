class Employee < ApplicationRecord
  belongs_to :user
  belongs_to :admin, class_name: 'User', foreign_key: 'reference_by_id'
  belongs_to :department
  has_many :bills

  # Validations
  validates :first_name, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :last_name, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
  validates :designation, presence: true
  validates :department_id, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
