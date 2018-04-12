ack(0, X, s(X)).
ack(s(X), 0, Y) :-
    ack(X, s(0), Y).
ack(s(X), s(Y), Z) :-
    ack(s(X), Y, A),
    ack(X, A, Z).

