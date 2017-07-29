class Wallet < ApplicationRecord
  belongs_to :user
  has_many :payments

  def to_proto
    Bank::Wallet.new(
      id: self.id,
      total: total,
      recent_payments: payments.recent(10).map(&:to_proto)
    )
  end

  def total
    payments.pluck(:amount).inject{ |m,x| m + x }
  end
end
