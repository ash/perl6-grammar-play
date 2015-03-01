my regex number_regex { \d \d }
my token number_token { <[\d]> <[\d]> }
my rule number_rule { <[\d]> <[\d]> }

say "42 ~~ number_regex: ";
say '42' ~~ m/<number_regex>/;

say "42 ~~ number_token: ";
say '42' ~~ m/<number_token>/;

say "42 ~~ number_rule: ";
say '42' ~~ m/<number_rule>/;

say "4 2 ~~ number_regex: ";
say '4 2' ~~ m/<number_regex>/;

say "4 2 ~~ number_token: ";
say '4 2' ~~ m/<number_token>/;

say "4 2 ~~ number_rule: ";
say '4 2' ~~ m/<number_rule>/;
