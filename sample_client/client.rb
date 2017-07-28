require 'grpc'
require 'pry'
require 'active_support/all'

proto_lib_dir = "#{__dir__}/../proto/lib/"
$LOAD_PATH.unshift(proto_lib_dir)
Dir.glob("#{proto_lib_dir}**/*.rb").each { |f| require f }

PORT = '0.0.0.0:11111'

def detect_service_stub(svc)
  klass = "Bank::#{svc.camelize}::Stub".constantize
  klass.new(PORT, :this_channel_is_insecure)
end

binding.pry
