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
%  inserts an element somewhere in a list
ex_insert(Elem, List, ResultList) :-
    ex_append(A, B, List),
    ex_append(A, [Elem|B], ResultList).


% ex_remove(Elem, List, ResultList).
%  removes an element from a list
ex_remove(Elem, List, ResultList) :-
    ex_append(List1, [Elem|Tail], List),
    ex_append(List1, Tail, ResultList).


% ex_permutation(List, ResultList).
%  creates a permutation of the given list
ex_permutation([], []).
ex_permutation([H|T], ResultList) :-
    ex_permutation(T, Perm),
    ex_insert(H, Perm, ResultList).


% ex_isSorted(List).
%  checks wheter the given list is sorted
ex_isSorted([]).
ex_isSorted([_]).
ex_isSorted([H, H2|T]) :-
    ex_isSorted([H2|T]),
    H=<H2.


% ex_logicIsSorted(List).
%  checks wheter the given list is sorted
ex_logicIsSorted(List) :-
    not(( ex_infix([X, Y], List),
          X>Y
        )).


% ex_slowSort(List, SortedList).
%  please don't use this...
ex_slowSort(List, SortedList) :-
    ex_permutation(List, SortedList),
    ex_isSorted(SortedList).


% ex_partition(Pivot, List, LL, RL).
%  the partition function used by quick sort
ex_partition(_, [], [], []).
ex_partition(Pivot, [H|T], [H|LL], RL) :-
    H<Pivot,
    ex_partition(Pivot, T, LL, RL).
ex_partition(Pivot, [H|T], LL, [H|RL]) :-
    H>=Pivot,
    ex_partition(Pivot, T, LL, RL).


% ex_quickSort(List, SortedList).
%  uses quick sort to sort the given list
ex_quickSort([], []).
ex_quickSort([H|T], Result) :-
    ex_partition(H, T, LT, RT),
    ex_quickSort(LT, SLT),
    ex_quickSort(RT, SRT),
    ex_append(SLT, [H|SRT], Result).


% ex_min(List, ResultElem).
%  returns the smallest element in a list
ex_min(List, ResultElem) :-
    ex_member(ResultElem, List),
    not(( ex_member(X, List),
          X<ResultElem
        )).


% ex_max(List, ResultElem).
%  returns the largest element in a list
ex_max(List, ResultElem) :-
    ex_member(ResultElem, List),
    not(( ex_member(X, List),
          X>ResultElem
        )).


% ex_nthElement(Index, List, Element)
%  returns the n-th element of a list
%  or checks if the n-th element is the given
ex_nthElement(0, [Elem|_], Elem).
ex_nthElement(N, [_|T], Elem) :-
    ex_nthElement(M, T, Elem),
    N is M+1.
