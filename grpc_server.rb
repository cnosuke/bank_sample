class GrpcServer
  PORT = '127.0.0.1:8080'

  def initialize
    @server = GRPC::RpcServer.new
    @server.add_http2_port(PORT, :this_port_is_insecure) # FIXME
  end

  def set_handler(handler_klass)
    @server.handle(handler_klass.new)
  end

  def run
    puts "Starting to listen: #{PORT}"

    @server.run
  end
end

server = GrpcServer.new
Grpc.constants.each do |svc|
  puts "Setting up GRPC Service: #{svc}"
  server.set_handler "Grpc::#{svc.to_s.camelize}".constantize
end

server.run
