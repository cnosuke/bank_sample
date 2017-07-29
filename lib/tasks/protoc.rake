namespace :protoc do
  desc 'Compile ProtoBuf'
  task compile: :environment do
    cmd
  end

  private

  def ruby_protc_plucgin_path
    `which grpc_tools_ruby_protoc_plugin`.chomp
  end

  def ruby_out
    File.join(Rails.root, 'proto/lib')
  end

  def grpc_out
    File.join(Rails.root, 'proto/lib')
  end

  def proto_files
    Dir.glob(File.join(Rails.root, 'proto', '*.proto'))
  end

  def proto_path
    File.join(Rails.root, 'proto')
  end

  def cmd
    cmd_str = [
      "protoc",
      "-I",
      proto_path,
      "--ruby_out=#{ruby_out}",
      "--grpc_out=#{grpc_out}",
      "--plugin=protoc-gen-grpc=#{ruby_protc_plucgin_path}",
      proto_files,
    ].flatten.join(' ')

    puts cmd_str
    system(cmd_str)
  end
end
