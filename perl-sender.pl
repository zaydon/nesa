use IO::Socket::INET;

$socket = IO::Socket::INET->new(PeerAddr => "192.168.220.115",
								PeerPort => "7030",
								Proto	 => "tcp",
								Type	 => SOCK_STREAM)
		or die "keine Verbindung zu $remote_host:$remote_port : $!\n";

# an den Server senden
print $socket "<message shootingrange='1'>welcome, here i am</message>";

# Antwort vom Server
$answer = <$socket>;
print $answer;

# Verbindung schliessen
close($socket);