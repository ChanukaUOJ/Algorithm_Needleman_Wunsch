use List::Util qw(max);

#initialize the sequence
$sequence1 = "ATGCT";
$sequence2 = "AGCT";

#scoring values
$match = 1;
$mismatch = -1;
$gap = -2;

#step1 -> making the match_checking matrix
@main_matrix;
@match_checker_matrix;

#add sequence into arrays
my @chars1 = split("",$sequence1);
my @chars2 = split("",$sequence2);

#read the arrays and storing
for(my $i=0; $i<length($sequence1); $i++){
    for(my $j=0; $j<length($sequence2); $j++){
        if($chars1[$i] eq $chars2[$j]){
            $match_checker_matrix[$i][$j] = $match;
            print(" ",$match_checker_matrix[$i][$j]," ");
        } else {
            $match_checker_matrix[$i][$j] = $mismatch;
            print("",$match_checker_matrix[$i][$j]," ");
        }
    }
    print("\n");
}

print("\n\n");

#step2 -> matrix filling
for(my $i=0; $i<length($sequence1)+1; $i++){
    $main_matrix[$i][0] = $i * $gap;
}

for(my $j=0; $j<length($sequence2)+1; $j++){
    $main_matrix[0][$j] = $j * $gap;
}

for(my $i=1; $i<length($sequence1)+1; $i++){
    for(my $j=1; $j<length($sequence2)+1; $j++){
        $main_matrix[$i][$j] = max($main_matrix[$i-1][$j] + $gap,
                                    $main_matrix[$i][$j-1] + $gap,
                                    $main_matrix[$i-1][$j-1] + $match_checker_matrix[$i-1][$j-1]);
    }
}

for(my $i=0; $i<length($sequence1)+1; $i++){
    for(my $j=0; $j<length($sequence1)+1; $j++){
        print(" ",$main_matrix[$i][$j]," ");
    }
    print("\n");
}

print("\n\n");

#step3 -> traceback

$align1 = "";
$align2 = "";

$ti = length($sequence1);
$tj = length($sequence2);

while($ti > 0 and $tj > 0){
    if($main_matrix[$ti][$tj] == $main_matrix[$ti-1][$tj-1] + $match_checker_matrix[$ti-1][$tj-1]){
        $align1 = $chars1[$ti-1].$align1;
        $align2 = $chars2[$tj-1].$align2;
        $ti = $ti-1;
        $tj = $tj-1;
    } 
    elsif($ti > 0 and $main_matrix[$ti][$tj] == $main_matrix[$ti-1][$tj] + $gap){
        $align1 = $chars1[$ti-1].$align1;
        $align2 = "_".$align2;
        $ti = $ti - 1;
    }
    else{
        $align1 = "_".$align1;
        $align2 = $chars2[$tj-1].$align2;
        $tj = $tj -1;
    }
}

print($align1."\n".$align2);