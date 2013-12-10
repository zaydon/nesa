#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);
use IO::Socket::INET;
my $client;

my $localport = 7030;
my $server    = IO::Socket::INET->new(
    LocalPort => $localport,
    Type      => SOCK_STREAM,
    Reuse     => 1,
    Listen    => 10 )
    or die "Unable to spawn server on port $localport: $!\n";

while ($client = $server->accept()) {
    # $client is the new connection
    #say my $answer = <$client> =~ s/\R\z//r;

    #send
    while (1) {
    my $data = "<command>get_status</command><command>get_settings</command>";
    $client->send($data);
    #my $data = <$client>;

    #$client->recv($data, 1024);
    print "Received from Client: $data\n";
	
	$client->recv($data,1024);
	print "Received from Client : $data\n";    
	}
}

close($server);
