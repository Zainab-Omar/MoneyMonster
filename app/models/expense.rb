# rubocop: disable Layout/LineLength
class Expense < ApplicationRecord
  validates :name, :amount, presence: true
  validates :name, format: { with: /[a-zA-Z0-9]/ }
  validates :amount, numericality: true

  belongs_to :author, class_name: 'User'
  has_many :groupedtransactions, dependent: :destroy
  has_many :groups, through: :groupedtransactions
  scope :ordered_by_most_recent, -> { order(created_at: :desc) }
  scope :stand_alone_expenses, -> { where('expenses.id NOT IN (?)', Groupedtransaction.distinct.pluck(:expense_id)) }
  scope :total_amount, -> { sum(:amount) }
  scope :for_the_month, -> { where('extract(year from expenses.created_at) = ? and extract(month from expenses.created_at)= ?', Date.today.year, Date.today.month) }
end
# rubocop: enable Layout/LineLength
