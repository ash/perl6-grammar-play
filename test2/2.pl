grammar Lang {
    rule TOP {        
        ^ <statements> $  {make $/.ast}
    }

    rule statements {
        <statement>+ %% ';'  {make $/.ast}
    }

    rule statement {
        <assignment> {make $/.ast}
    }

    rule assignment {
        <identifier> '=' <value> {make 'assign' => [~$<identifier>, +$<value>]}
    }

    token identifier {
        (\w+) {make ~$0}
    }

    token value {
        (\d+) {make +$0}
    }
}

my $parsed = Lang.parsefile('2.lang');
say $parsed;
say $parsed.perl;
