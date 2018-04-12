/*  File:    sld_tree.pl
    Author:  Przemyslaw Kobylanski
    Created: Jun  2 2006
    Purpose: SLD-tree visualization
*/

:- module(sld_tree, [sld_tree/1]).


% sld_tree(+Goal)
%
% Rysuje SLD-drzewo dla zadanego celu. Narysowane drzewo zostaje
% zapisane w pliku sldtree<n>.eps, gdzie n jest kolejnym numerem.
%
% Przyklad wywolania:
%
% ?- use_module(library(lists)).
% ?- sld_tree(append(X, Y, [1, 2, 3])).
% X = [],
% Y = [1, 2, 3] ;
% X = [1],
% Y = [2, 3] ;
% X = [1, 2],
% Y = [3] ;
% X = [1, 2, 3],
% Y = [] ;
% % SLD-drzewo zapisano w pliku: sldtree1.eps
% true.

sld_tree(Goal) :-
	term_to_atom(:- Goal, Label),
	atom_concat('SLD-tree for ', Label, Name),
	new(Window, picture(Name)),
	sld_tree(Goal, Window).

sld_tree(Goal, Window) :-
	new_node(Goal, Root),
	new(Tree, tree(Root)),
	send(Tree, direction, vertical),
	send(Tree, neighbour_gap, 10),
	send(Window, display, Tree),
	send(Window, open),
	go(Goal, Root).
sld_tree(_, Window) :-
	gensym(sldtree, Id),
	atom_concat(Id, '.eps', FileName),
	new(File, file(FileName)),
	send(File, open, write),
	send(File, append, Window?postscript),
	send(File, close),
	format('% SLD-drzewo zapisano w pliku: ~w~n', [FileName]),
	send(File, done).

new_node(true, Node) :- !,
	new(Box, box(10, 10)),
	send(Box, fill_pattern, colour(red)),
	new(Node, node(Box)).
new_node(Goal, Node) :-
	term_to_atom(:- Goal, Label),
	new(Node, node(text(Label))).

go((_; _), _) :-
	format('% nie korzystaj z alternatywy (;)~n'),
	abort.
go((_ -> _), _) :-
	format('% nie korzystaj z implikacji (->)~n'),
	abort.
go(true, _) :- !.
go(((G1, G2), G3), Current) :- !,
	go((G1, (G2, G3)), Current).
go((Atom, Goal), Current) :- !,
	clause(Atom, Body),
	new_goal(Body, Goal, NewGoal),
	new_node(NewGoal, Next),
	send(Current, son, Next),
	go(NewGoal, Next).
go(Atom, Current) :-
	clause(Atom, Body),
	new_node(Body, Next),
	send(Current, son, Next),
	go(Body, Next).

new_goal(true, G, G) :- !.
new_goal(G1, G2, (G1, G2)).

