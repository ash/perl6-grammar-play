grammar G {
    token TOP {^ <expression>+ $}
    token expression {\h* <identifier> \h* '=' \h* <value> \h* ';' \h*}
    token identifier {\w+}
    token value {\d+}
}

my $p = G.parsefile('1.lang');
say $p.perl;

