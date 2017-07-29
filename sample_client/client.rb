require 'grpc'
require 'pry'
require 'active_support/all'

proto_lib_dir = "#{__dir__}/../proto/lib/"
$LOAD_PATH.unshift(proto_lib_dir)
Dir.glob("#{proto_lib_dir}**/*.rb").each { |f| require f }

PORT = '127.0.0.1:8080'
INSECURE = :this_channel_is_insecure

svc = Bank::WalletService::Stub.new(PORT, INSECURE)
payments = [
  Bank::Payment.new(amount: -100, target: '自販機', reason: 'コーラ'),
  Bank::Payment.new(amount: -500, target: 'コンビニ', reason: 'おにぎり'),
]
req = Bank::AddPaymentsRequest.new(user_id: 1, payments: payments)

res = svc.add_payments(req)
p res.wallet

binding.pry
