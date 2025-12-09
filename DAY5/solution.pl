
sub is_ingredient_fresh{
    my $ingredient = $_[1];
    my @fresh_ingredients = @{$_[0]};
    for (my $i = 0; $i < scalar(@fresh_ingredients); $i++) {
        my @range = split /-/, @fresh_ingredients[$i];
        if ($ingredient >= $range[0] and $ingredient <= $range[1]){
            return 1;
        }
    }
    return 0;
}

my $filename = "input.txt";

open my $fh, '<', $filename or die "Cannot open $filename: $!";

my @fresh_ingredients = ();
my @all_ingredients = ();
my $ranges = 0;
my @lines = <$fh>;
foreach my $line (@lines) {
    # $line =~ s/\s+//g; # remove whitespace
    chomp $line;
	if ($ranges == 0){
        if ($line eq ""){
            $ranges = 1;
            next;
        } else {
            push @fresh_ingredients, $line;
        }
    } else {
        push @all_ingredients, $line;
    }
}
close $fh;

my $Total_fresh = 0;
for (my $i = 0; $i < scalar(@all_ingredients); $i++) {
    my $ingredient = $all_ingredients[$i];
    my $is_fresh = is_ingredient_fresh(\@fresh_ingredients, $ingredient);
    if ($is_fresh){
        # print "Ingredient " . $ingredient . " is fresh!\n";
        $Total_fresh += 1;
    } else {
        # print "Ingredient " . $ingredient . " is NOT fresh!\n";
    }
}

print "Total fresh ingredients: " . $Total_fresh . "\n";