

require "xmlrpc/client"

#
# Verified working on ports 50500 to 50550, its suggested
# to work only within ports 50500-50550
#
#




# hard coded to connect to e5-01-02, use what you like
#ourServer = XMLRPC::Client.new('129.128.211.42', "/RPC2", 50500)
ourServer = XMLRPC::Client.new(ENV['HOSTNAME'], "/RPC2", 50500)

puts "Add 5 and 3"
puts ourServer.call('num.add', 5, 3)

puts "Div 24 and 6"
puts ourServer.call('num.div', 24, 6)

aProxy = ourServer.proxy("num")

puts "Proxy add 6 and 10"
puts aProxy.add(6, 10)

puts "Proxy div 70 by 5"
puts aProxy.div(70, 5)

