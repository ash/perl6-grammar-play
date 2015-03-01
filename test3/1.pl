my regex weekday {[Mon | Tue | Wed | Thu | Fri | Sat | Sun]};
say 'Thu' ~~ m/<weekday>/;
say 'Thy' ~~ m/<weekday>/;

my $m = 'Wed' ~~ m/<weekday>/;
say $m.WHAT;

