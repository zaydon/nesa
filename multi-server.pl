#!/usr/bin/perl

use strict;
use warnings;
use IO::Socket::INET;
use IO::Select;

my ($readable_handles,
    $main_socket, $sock, $new_sock, $buf);

$main_socket = new IO::Socket::INET (
    LocalPort => '7030',
    Type      => SOCK_STREAM,
    Listen => 10,
    Reuse => 1
    ) 
        or die "ERROR in Socket Creation : $!\n";


$readable_handles = new IO::Select();
$readable_handles->add($main_socket);

while (1) {  #Infinite loop
    # select() blocks until a socket is ready to be read or written
    (my $new_readable) = IO::Select->select($readable_handles,
                                         undef, undef, 0);
    # If it comes here, there is at least one handle
    # to read from or write to. For the moment, worry only about 
    # the read side.
    foreach $sock (@$new_readable) {
        if ($sock == $main_socket) {
            $new_sock = $sock->accept();
            # Add it to the list, and go back to select because the 
            # new socket may not be readable yet.
            $readable_handles->add($new_sock);
          } else {
            # It is an ordinary client socket, ready for reading.
            $buf = <$sock>;
            if ($buf) {
                # .... Do stuff with $buf
                print "BUF: $buf\n";
            } else {
                # Client closed socket. We do the same here, and remove
                # it from the readable_handles list
                $readable_handles->remove($sock);
                close($sock);
            }
        }
    }   
}