use strict;
use warnings;

sub is_valid {
	my $num = $_[0];
	my $num_length = length($num);
	# print "Num is $num\n";
	my $is_num_valid = 1;
	foreach my $pattern_length (1 .. $num_length / 2){
		my $test_pattern = substr($num, 0, $pattern_length);
		my $is_test_pattern_valid = 1;
		# for each possible length
		# check if each itteration equals the test pattern
		# print "Test pattern is $test_pattern\n";
		foreach my $i (0 .. ($num_length / $pattern_length)-1){
			my $to_test = substr($num, $i * $pattern_length, $pattern_length);
			# print "\tTesting $test_pattern against $to_test\n";
			if ($test_pattern ne $to_test){
				$is_test_pattern_valid = 0;
				# last;
			}
		}
		if($is_test_pattern_valid){
			$is_num_valid = 0;
		}
		# print "Is test pattern valid?: $is_test_pattern_valid\n";
	}
	if(!$is_num_valid){
		# print "Invalid number is $num\n";
	}
	# print "Valid?: $is_num_valid\n";
	return $is_num_valid;
}

sub check_for_valid_ids {
	my $total = 0;
	my $range = $_[0];
	# print "Range is : $range\n";
	my @start_end = split('-', $range);
	# print "Start is $start_end[0]\n";
	# print "End is $start_end[1]\n";
	foreach my $val ($start_end[0] .. $start_end[1]){
		if (not is_valid($val)){
			$total += $val;	
		}
	}
	return $total;
}

# my $total = 0;
# $total = check_for_valid_ids("446443-446449");
# print "Total is: $total\n";

#is_valid("111111");
#is_valid("123123");
#is_valid("123");
#is_valid("1122");

# =begin

my $filename = "input.txt";
open(my $fh, "<", $filename) or die "Cannot open file '$filename': $!";

while (my $line = <$fh>){
	chomp $line;
	# print "Read line: $line\n";
	my @id_ranges = split(',', $line);
	my $total = 0;
	for my $i (0 .. $#id_ranges) {
		print "Checking ranges @id_ranges[$i]\n";
		$total += check_for_valid_ids(@id_ranges[$i]);
	}
	print "Total is: $total\n";
}

close($fh);

# =end
