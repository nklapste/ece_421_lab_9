

require "xmlrpc/server"

port = 50500
#
# Verified working on ports 50500 to 50550, its suggested
# to work only within ports 50500-50550
#

class Num
   INTERFACE = XMLRPC::interface("num") {
   meth 'int add(int, int)', 'Add two numbers', 'add'
   meth 'int div(int, int)', 'Divide two numbers'
}
   def add(a, b) a + b end
   def div(a, b) a / b end
end

server = XMLRPC::Server.new(port, ENV['HOSTNAME'])

server.add_handler(Num::INTERFACE,  Num.new)

server.serve
