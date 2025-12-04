sub recursive_find_joltage{
	my $joltage = @_[0];
	my $batteries = @_[1];
	my $intended_joltage_length = 12;
	if (length($joltage) >= $intended_joltage_length){
		return $joltage;
	}
	my $batteries_to_check = substr($batteries, 0, length($batteries)-11+length($joltage));
	foreach my $target (reverse 1 .. 9){
		for (my $index = 0; $index < length($batteries_to_check); $index++){
			my $to_check = substr($batteries_to_check, $index, 1); # this isn't working
			if ($target eq $to_check){
				$joltage = $joltage . $target;
				$batteries = substr($batteries, $index+1);
	 			return recursive_find_joltage($joltage, $batteries);
			}
		}
	}
	return 0;
}

use strict;
use warnings;

my $filename = "input.txt";

open(my $fh, "<", $filename) or die "Cannot open file '$filename': $!";

my $sum = 0;

while (my $line = <$fh>){
	chomp $line;
	$sum += recursive_find_joltage("", $line);
}

close($fh);

print "Sum is $sum\n";

