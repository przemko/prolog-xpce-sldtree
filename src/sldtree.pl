/*  File:    sldtree.pl
    Author:  Przemyslaw Kobylanski
    Created: Jun  2 2006
    Purpose: SLD-tree visualization
*/

    :- module(sldtree, [sldtree/1]).


% sldtree(+Cel)
%
% Rysuje SLD-drzewo dla zadanego celu. Narysowane drzewo zostaje
% zapisane w pliku sldtree<n>.eps, gdzie n jest kolejnym numerem.
%
% Przyklady wywolania:
%
% ?- sldtree(append(X, Y, [1, 2, 3]).
%

sldtree(Cel) :-
	new(Okno, picture('SLD-tree')),
	drzewo(Cel, Korzen),
	new(Drzewo, tree(Korzen)),
	send(Drzewo, direction, vertical),
	send(Drzewo, neighbour_gap, 10),
	send(Okno, display, Drzewo),
	send(Okno, open),
	gensym(sldtree, Id),
	atom_concat(Id, '.eps', NazwaPliku),
	new(File, file(NazwaPliku)),
	send(File, open, write),
	send(File, append, Okno?postscript),
	send(File, close),
	format('% SLD-drzewo zapisano w pliku: ~w\n', [NazwaPliku]),
	send(File, done).

drzewo(true, Wierzcholek) :- !,
	new(Wierzcholek, node(box(10, 10))).
drzewo((Atom, Cel), Ojciec) :- !,
	term_to_atom(:- (Atom, Cel), Napis),
	new(Ojciec, node(text(Napis))),
	forall(clause(Atom, Cialo),
	       (dopisz(Cialo, Cel, NowyCel),
		drzewo(NowyCel, Syn),
		send(Ojciec, son, Syn))).
drzewo(Atom, Ojciec) :- !,
	term_to_atom(:- Atom, Napis),
	new(Ojciec, node(text(Napis))),
	forall(clause(Atom, Cialo),
	       (drzewo(Cialo, Syn),
		send(Ojciec, son, Syn))).

dopisz(true, Cel, Cel) :- !.
dopisz((A, B), Cel, (A, NowyCel)) :- !,
	dopisz(B, Cel, NowyCel).
dopisz(A, Cel, (A, Cel)) :- !.




