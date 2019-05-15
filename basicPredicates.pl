% ex_isList(List).
%  cheks wheter the argument is a list
ex_isList([]).
ex_isList([_|_]).


% ex_append(List, LatterList, ResultList).
%  appends the latter to the former list
%  and stores it in the result list
ex_append([], Latter, Latter).
ex_append([Head|Tail], Latter, [Head|Result]) :-
    ex_append(Tail, Latter, Result).


% ex_member(Elem, List).
%  checks wheter the list contains that element
ex_member(Elem, [Elem|_]).
ex_member(Elem, [_|Tail]) :-
    ex_member(Elem, Tail).


% ex_last(Elem, List).
%  returns the last element of the list
ex_last(Elem, [Elem]).
ex_last(Elem, [_|Tail]) :-
    ex_last(Elem, Tail).


% ex_length(List, Len).
%  returns the length of a list
ex_length([], 0).
ex_length([_|T], N) :-
    ex_length(T, M),
    N is M+1.


% ex_reverse(List, ReversedList).
%  creates a reversed list
ex_reverse(List, RevList) :-
    ex_reverse(List, RevList, []).
ex_reverse([], Buff, Buff).
ex_reverse([H|T], R, Acc) :-
    ex_reverse(T, R, [H|Acc]).


% ex_prefix(Prefix, List).
%  checks if list is a prefix of another
%  or returns the prefixes of a list
ex_prefix(Prefix, List) :-
    ex_append(Prefix, _, List).


% ex_suffix(Suffix, List).
%  checks if list is a suffix of another
%  or returns the suffixes of a list
ex_suffix(Suffix, List) :-
    ex_append(_, Suffix, List).


% ex_infix(Infix, List).
%  checks if list is an Infix of another
%  or returns the Infixes of a list
ex_infix(Infix, List) :-
    ex_suffix(Suffix, List),
    ex_prefix(Infix, Suffix).


% ex_insert(Elem, List, ResultList).
%  inserts an element
ex_insert(Elem, List, ResultList) :-
    append(A, B, List),
    append(A, [Elem|B], ResultList).
