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
    say my $answer = <$client> =~ s/\R\z//r;
}

close($server);
