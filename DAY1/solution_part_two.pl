        
use strict;
use warnings;

# my $input_file = "testInput.txt";
my $input_file = "input.txt";

open(my $fh, "<", $input_file) or die "Could not open input file";

my $password = 0;
my $dial_state = 50;

while (my $line = <$fh>){
	chomp $line;
	my $first_char = substr($line, 0, 1);
	my $change = substr($line, 1);
	if ($first_char eq "L") {
		$change *= -1;
	}
	
	print "Change is $change\n";

	while ($change != 0) {
		if ($change > 0) {
			$change--;
			$dial_state++;
		} else {
			$change++;
			$dial_state--;
		}
		if ($dial_state == 100){
			$dial_state = 0;
		}
		if ($dial_state == -1){
			$dial_state = 99;
		}
		if ($dial_state == 0){
			$password++;
		}
	}

	print "Dial State: $dial_state\n";
}
print "Password is $password \n";
print "Done \n";

