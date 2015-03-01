my %var;

grammar G {
    token TOP {^ <statement>+ %% \n+ $}

    token statement {
          <assignment>
        | <printout>
        | <inc>
        | <dec>
    }

    token assignment {
        <identifier> '=' <value>
        {
            %var{~$<identifier>} = +$<value>;
        }
    }

    token inc {
        <identifier> '++'
        {
            %var{~$<identifier>}++;
        }
    }

    token dec {
        <identifier> '--'
        {
            %var{~$<identifier>}--;
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

my $p = G.parsefile('4.lang');
say $p.perl;
