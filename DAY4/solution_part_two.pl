# use strict;
# use warnings;
use Storable qw(dclone);

sub check_location{
	my @all_rolls = @{$_[0]}; # this dereferences the rolls array back into a variable
	my @coord_to_check = @{$_[1]}; # this dereferences the coords array back into a variable
	
	# these two if statements check if the coord is out of bounds
	if ($coord_to_check[0] < 0 or $coord_to_check[1] < 0){
		return 0;
	}
	my $row_length = scalar(@all_rolls[$coord_to_check[0]]);
	my $col_length = scalar(@all_rolls);
	if ($coord_to_check[0] > $col_length or $coord_to_check[1] > $row_length){ # this is broken
		return 0;
	}

	return $all_rolls[$coord_to_check[0]][$coord_to_check[1]] eq "@" ? 1 : 0;
}

sub get_adjacent_rolls{
	my @all_rolls = @{$_[0]};
	my @target_coords = @{$_[1]};
	my $adjacent_rolls = 0;

	# check all eight adjacent rolls
	my @eight_cells = ([-1, -1],[-1, 0], [-1, 1]);
	push @eight_cells, ([0, -1],[0, 1]);
	push @eight_cells, ([1, -1], [1, 0], [1, 1]);

	foreach my $offset (@eight_cells){
		my $x_offset = $offset->[0];
		my $y_offset = $offset->[1];
		my @new_coord = ($target_coords[0][0] + $x_offset, $target_coords[0][1] + $y_offset);
		# print "Checking coord " . $new_coord[0] . ", " . $new_coord[1] . "\n";
		my $is_valid = check_location(\@all_rolls, \@new_coord);
		if ($is_valid){
			$adjacent_rolls += 1;
		}
	}

	return $adjacent_rolls;
}

my $filename = "input.txt";

open my $fh, '<', $filename or die "Cannot open $filename: $!";

my @all_rolls = ();
my @lines = <$fh>;
foreach my $line (@lines) {
	chomp $line;
	push @all_rolls, [split //, $line];
}

close $fh;


sub remove_rolls{
	my @all_rolls = @{$_[0]};
	my @output_rolls = @{ dclone(\@all_rolls) };
	my $accessible = 0;
	for (my $i = 0; $i < scalar(@all_rolls); $i++) {
		for (my $j = 0; $j < scalar(@{$all_rolls[$i]}); $j++) {
			my @coords = [$i, $j];
			if ($all_rolls[$i][$j] ne "@") {
				next;
			}
			my $adjacent_count = get_adjacent_rolls(\@all_rolls, \@coords);
			if ($adjacent_count < 4) {
				$accessible += 1;
				$output_rolls[$i][$j] = ".";
			}
		}
	}
	return $accessible, @output_rolls;
}

my $total_accessible = 0;
my $accessible = 0;
do{
	my @new_rolls = ();
	($accessible, @new_rolls) = remove_rolls(\@all_rolls);
	$total_accessible += $accessible;
	@all_rolls = @new_rolls;
} while ($accessible > 0);


print "Total accessible rolls: $total_accessible\n";
