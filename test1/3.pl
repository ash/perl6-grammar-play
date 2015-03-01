my %var;

grammar G {
    token TOP {^ <statement>+ %% \n+ $}

    token statement {
        <assignment> | <printout>
    }
    
    token assignment {
        <identifier> '=' <value>
        {
            %var{~$<identifier>} = +$<value>;
        }
    }
    
    token printout {
        'print' <.ws> <identifier>
        {
            say %var{$<identifier>};
        }
    }

    token identifier {\w+}
    token value {\d+}
}

my $p = G.parsefile('3.lang');
say $p;
