grammar Calc {
    rule TOP {
        ^ <expression> $
    }
    rule expression {
        | <term> [$<op>=(['+'|'-']) <term>]*
        | <group>
    }
    rule term {
        <factor> [$<op>=(['*'|'/']) <factor>]*
    }
    rule factor {
        | <value>
        | <group>
    }
    rule group {
        '(' <expression> ')'
    }
    token value {
        | \d+['.' \d+]*
        | '.' \d+
    }
}

class GrammarAction {
    method TOP($/) {
        $/.make: $<expression>.ast
    }

    method expression($/) {
        if $<group> {
            $/.make: $<group>.ast
        }
        else {
            my $result = $<term>[0].ast;

            if $<op> {
                my @ops = $<op>.map(~*);
                my @vals = $<term>[1..*].map(*.ast);

                for 0..@ops.elems - 1 -> $c {
                    if @ops[$c] eq '+' {
                        $result += @vals[$c];
                    }
                    else {
                        $result -= @vals[$c];
                    }
                }
            }

            $/.make: $result;
        }
    }

    method term($/) {
        my $result = $<factor>[0].ast;

        if $<op> {
            my @ops = $<op>.map(~*);
            my @vals = $<factor>[1..*].map(*.ast);

            for 0..@ops.elems - 1 -> $c {
                if @ops[$c] eq '*' {
                    $result *= @vals[$c];
                }
                else {
                    $result /= @vals[$c];
                }
            }
        }

        $/.make: $result;
    }

    method factor($/) {
        if $<value> {
            $/.make: +$<value>
        }
        else {
            $/.make: $<group>.ast
        }
    }

    method group($/) {
        $/.make: $<expression>.ast
    }
    
    method value($/) {
        $/.make: +$/
    }
}

my $calc = Calc.subparse(@*ARGS[0], :actions(GrammarAction.new()));
say $calc.ast;
#say $calc;
#say $calc.perl;
