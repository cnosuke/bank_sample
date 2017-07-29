class Payment < ApplicationRecord
  belongs_to :wallet
  scope :recent, -> (i) { order(id: :desc).limit(i) }

  def to_proto
    Bank::Payment.new(
      id: id,
      amount: amount,
      target: target,
      reason: reason,
    )
  end
end
