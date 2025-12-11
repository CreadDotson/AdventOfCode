
my $input_file = "input.txt";
open(FH, '<', $input_file) or die "Could not open file '$input_file' $!";
my @lines = ();
while (my $line = <FH>) {
    chomp $line;
    push @lines, $line;
}

my $rows = scalar(@lines);
my $cols = scalar(split ' ', $lines[0]);
print "Rows: " . $rows . "\n";
print "Cols: " . $cols . "\n";

my @functions = split ' ', @lines[$rows - 1];
my $total = 0;

for(my $i = 0; $i < $cols; $i++){
    my @line_array = split ' ', $lines[$i];
    if (@functions[$i] eq "*"){
        # multiply
        my $result = 1;
        for (my $j = 0; $j < $rows - 1; $j++){
            my @line = split ' ', $lines[$j];
            $result = $result * @line[$i];
        }
        $total += $result;
    } elsif (@functions[$i] eq "+"){
        # add
        my $sum = 0;
        for (my $j = 0; $j < $rows - 1; $j++){
            my @line = split ' ', $lines[$j];
            $sum = $sum + @line[$i];
        }
        $total += $sum;
    }
}

print "Total: " . $total . "\n";