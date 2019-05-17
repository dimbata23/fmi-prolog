/*
  Problem 1
    Define a predicate compress(L, R) that removes
    consecutive duplicate elements in a list
  Example:
    [1,2,2,3,3,3,3,4,5,5,6,3,3,3]
        becomes
    [1,2,3,4,5,6,3]
*/
compress([], []).
compress([X], [X]).
compress([H1, H2|T], [H1|Result]) :-
    H1\=H2,
    compress([H2|T], Result).
compress([H1, H1|T], Result) :-
    compress([H1|T], Result).


/*
  Problem 2
    Define a predicate removeNth(List, N, Result)
    that removes every nth element of a list
*/
removeNth(List, N, Result) :-
    rnth(List, N, 1, Result).
rnth([], _, _, []).
rnth([_|T], N, N, Result) :-
    rnth(T, N, 1, Result).
rnth([H|T], N, Curr, [H|Result]) :-
    N\=Curr,
    Next is Curr+1,
    rnth(T, N, Next, Result).

