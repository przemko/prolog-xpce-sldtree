add(0, X, X).
add(s(X), Y, s(Z)) :-
    add(X, Y, Z).

fib(0, s(0)).
fib(Y, Z) :-
    fib(X, Y),
    add(X, Y, Z).

