grammar Lang {
    rule TOP {
        ^ <statement>+ %% ';' $
    }

    rule statement {
        <assignment>
    }

    rule assignment {
        <identifier> '=' <value>
    }

    token identifier {
        $<identifier>=(\w+)
    }

    token value {
        \d+
    }
}

my $parsed = Lang.parsefile('1.lang');
say $parsed;
say $parsed.perl;