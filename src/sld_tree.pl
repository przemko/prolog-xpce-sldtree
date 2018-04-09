/*  File:    sld_tree.pl
    Author:  Przemyslaw Kobylanski
    Created: Jun  2 2006
    Purpose: SLD-tree visualization
*/

:- module(sld_tree, [sld_tree/1]).


% sldtree(+Goal)
%
% Rysuje SLD-drzewo dla zadanego celu. Narysowane drzewo zostaje
% zapisane w pliku sldtree<n>.eps, gdzie n jest kolejnym numerem.
%
% Przyklad wywolania:
%
% ?- use_module(library(lists)).
% ?- sld_tree(append(X, Y, [1, 2, 3]).
%

sld_tree(Goal) :-
	new(Window, picture('SLD-tree')),
	sld_tree(Goal, Root),
	new(Tree, tree(Root)),
	send(Tree, direction, vertical),
	send(Tree, neighbour_gap, 10),
	send(Window, display, Tree),
	send(Window, open),
	gensym(sldtree, Id),
	atom_concat(Id, '.eps', FileName),
	new(File, file(FileName)),
	send(File, open, write),
	send(File, append, Window?postscript),
	send(File, close),
	format('% SLD-drzewo zapisano w pliku: ~w~n', [FileName]),
	send(File, done).

sld_tree(true, Node) :- !,
	new(Node, node(box(10, 10))).
sld_tree((_; _), _) :- !,
	format('% nie korzystać z alternatywy (;)~n'),
	abort.
sld_tree((_ -> _), _) :- !,
	format('% nie korzystać z implikacji (->)~n'),
	abort.
sld_tree((Atom, Goal), Father) :- !,
	term_to_atom(:- (Atom, Goal), Label),
	new(Father, node(text(Label))),
	forall(clause(Atom, Body),
	       (new_goal(Body, Goal, NewGoal),
		sld_tree(NewGoal, Son),
		send(Father, son, Son))).
sld_tree(Atom, Father) :-
	term_to_atom(:- Atom, Label),
	new(Father, node(text(Label))),
	forall(clause(Atom, Body),
	       (sld_tree(Body, Son),
		send(Father, son, Son))).

new_goal(true, Goal, Goal) :- !.
new_goal((A, B), Goal, (A, NewGoal)) :- !,
	new_goal(B, Goal, NewGoal).
new_goal(A, Goal, (A, Goal)).




