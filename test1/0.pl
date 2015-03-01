grammar G {
    token TOP { \d+ }
}

say G.parse("123")
