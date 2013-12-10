#!/usr/bin/perl
#tcpserver.pl

use IO::Socket::INET;

# flush after every write
$| = 1;

my ($socket,$client_socket);
my ($peeraddress,$peerport);

# creating object interface of IO::Socket::INET modules which internally does 
# socket creation, binding and listening at the specified port address.
$socket = new IO::Socket::INET (
	LocalHost => '192.168.220.117',
	LocalPort => '7030',
	Proto => 'tcp',
	Listen => 5,
	Reuse => 1
	) 
		or die "ERROR in Socket Creation : $!\n";

$aus = "Waiting  client connection on port 7030\n";
print $aus;


while(1)
{
# waiting for new client connection.
$client_socket = $socket->accept();

# get the host and port number of newly connected client.
$peer_address = $client_socket->peerhost();
$peer_port = $client_socket->peerport();

print "Accepted New Client Connection From : $peer_address, $peer_port\n";

# write operation on the newly accepted client.
$data = "";
#print $client_socket "$data\n";
# we can also send the data through IO::Socket::INET module,
#$client_socket->send($data);

# read operation on the newly accepted client
$data = <$client_socket>;
# we can also read from socket through recv()  in IO::Socket::INET
$client_socket->recv($data,1024);
print "Received from Client : $data\n";
}

$socket->close();