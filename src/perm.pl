p1([], []).
p1(L, [X | L2]) :-
	select(X, L, L1),
	p1(L1, L2).

p2([], []).
p2([X | L1], L) :-
	p2(L1, L2),
	select(X, L, L2).

