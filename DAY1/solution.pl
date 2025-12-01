        
use strict;
use warnings;

# my $input_file = "example_input.txt";
my $input_file = "input.txt";

open(my $fh, "<", $input_file) or die "Could not open input file";

my $password = 0;
my $dial_state = 50;

while (my $line = <$fh>){
	chomp $line;
	my $first_char = substr($line, 0, 1);
	my $change = substr($line, 1);
	if ($first_char eq "L") {
		$dial_state -= $change;
		# print "left \n";
	} else {
		$dial_state += $change;
		# print "right \n";
	}
	while ($dial_state < 0){
		$dial_state += 100;
	}
	while ($dial_state >= 100){
		$dial_state -= 100;
	}
	if ($dial_state == 0) {
		$password++;
	}
	# print "Dial State: $dial_state\n";
}
print "Password is $password \n";
print "Done \n";

