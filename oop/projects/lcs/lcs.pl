#!/usr/bin/env perl
#
# This is a conversion of the Longest Common Subsequence algorithm in Perl, translated
# from C++. The algorithm, such that, given two strings of A and B, the program finds
# the longest sequence of characters that are common and in order between the two strings.
#
# Copyright (C) 2016 Joshua Nasiatka.
#--------------------------------------------------------------------------------------

my ($a, $b) = @ARGV;			# Take in two parameters as strings A and B

# Debugging Output
print ("A = ", $a, "\n");							# Print out string A for debugging purposes
print ("B = ", $b, "\n");							# Print out string B for debugging purposes
print ("===============\n");
print ("LCS = ", LCS($a, $b), "\n");	# Print the Longest Common Subsequence of the two strings

# Define sub routine, LCS
sub LCS {
	my ($a, $b) = @_;	 # Accept and Assign Inputs to Variables
	my $counts = [];   # Array of counts
	my $arrows = [];   # Array of arrows
	my $rowcount = length($b);
	my $colcount = length($a);

	# A string isn't going to help finding a subsequence, we need to look at this in terms
	# of characters, so we use "split" to splice at each character
	my @a = split("", $a);
	my @b = split("", $b);

	# Arrow directions for that array
	my $up         = 'U';
	my $left       = 'L';
	my $diagonal   = 'D';

  # Fill matrices with 0s in every cell in first row of both matrices
	for (my $j = 0; $j <= $colcount; $j++) {
		$counts[0][$j] = '0';
		$arrows[0][$j] = '0';
	}

  # Fill matrices with 0s in every cell in the first column
	for (my $j = 0; $j <= $rowcount; $j++) {
		$counts[$j][0] = '0';
		$arrows[$j][0] = '0';
	}

  # Dress the matrices with the LCS algorithm
  for (my $i = 1; $i <= $rowcount; $i++) {
    for (my $j = 1; $j <= $colcount; $j++) {
      if ($a[$j] == $b[$i]) {
        $counts[$i][$j] = $counts[$i-1][$j-1]+1;
        $arrows[$i][$j] = $diagonal;
      }

      if ($a[$j] != $b[$i]) {
        if ($counts[$i-1][$j] >= $counts[$i][$j-1]) {
          $counts[$i][$j] = $counts[$i-1][$j];
          $arrows[$i][$j] = $up;
        } else {
          $counts[$i][$j] = $counts[$i][$j-1];
          $arrows[$i][$j] = $left;
        }
      }
    }
  }

  # Print the matrix
  for (my $i = 0; $i <= $rowcount; $i++) {
    for (my $j = 0; $j <= $colcount; $j++) {
      if ($j != $colcount) {
        print $counts[$i][$j], " ";
      } else {
        print $counts[$i][$j], "\n";
      }
    }
  }
  print "\n";

  for (my $i = 0; $i <= $rowcount; $i++) {
    for (my $j = 0; $j <= $colcount; $j++) {
      if ($j != $colcount) {
        print $arrows[$i][$j], " ";
      } else {
        print $arrows[$i][$j], "\n";
      }
    }
  }
  print "\n";
  # Testing array contents
  # use Data::Dumper qw(Dumper);
  # print Dumper \@arrows;

  print "Here is your longest common subsequence: \n";
  return printLCS ($arrows, $a, $rowcount-1, $colcount-1);
  print "\n";

}

sub printLCS {
  my ($arrows, $a, $i, $j) = @_;
  my $lcs = '';

  while ($rowcount > 0 || $colcount > 0) {
    if ($arrows[$i][$j] == $diagonal) {
      $i--;
      $j--;
      $lcs = $a[$i].$lcs;
    } elsif ($arrows[$i][$j] == $up) {
      $i--;
    } elsif ($arrows[$i][$j] == $left) {
      $j--;
    } else {
      die ("Error");
    }
  }

  return $lcs;


}
