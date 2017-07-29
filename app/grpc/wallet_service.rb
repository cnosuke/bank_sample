class Grpc::WalletService < Bank::WalletService::Service
  def get_by_user_id(req, _call)
    user_id = req.user_id
    wallet = User.find_by(id: user_id).wallet

    if wallet.present?
      Bank::GetByUserIDResponse.new(wallet: wallet.to_proto)
    else
      raise GRPC::BadStatus.new_status_exception(
        GRPC::Core::StatusCodes::ABORTED,
        "Wallet(user_id=#{user_id}) isn't found.",
      )
    end
  end

  def add_payments(req, _call)
    user_id = req.user_id
    wallet = User.find_by(id: user_id).wallet
    payments = req.payments.map do |pay|
      wallet.payments.build(
        amount: pay.amount,
        target: pay.target,
        reason: pay.reason,
      )
    end

    if payments.all?(&:save)
      Bank::AddPaymentsResponse.new(wallet: wallet.to_proto)
    else
      raise GRPC::BadStatus.new_status_exception(
        GRPC::Core::StatusCodes::ABORTED,
        "Payment save failed.",
      )
    end
  end
end
