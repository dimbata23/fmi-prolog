% inUnion(Element, A, B).
%  checks whether the given element is contained in the union of A and B
%  or returns an element contained in the union of A and B
inUnion(Element, A, B) :-
    (   member(Element, A)
    ;   member(Element, B)
    ).


% inIntersection(Element, A, B).
%  checks whether the given element is contained in the intersection of A and B
%  or returns an element contained in the intersection of A and B
inIntersection(Element, A, B) :-
    member(Element, A),
    member(Element, B).


% inDifference(Element, A, B).
%  checks whether the given element is contained in the difference of A and B
%  or returns an element contained in the difference of A and B
inDifference(Element, A, B) :-
    member(Element, A),
    not(member(Element, B)).


% isSubsetOf(A, B).
%  checks whether or not A is a subset of B
isSubsetOf(A, B) :-
    not(( member(X, A),
          not(member(X, B))
        )).


% areEqualSets(A, B).
%  checks whether or not set A is equal to set B
areEqualSets(A, B) :-
    isSubsetOf(A, B),
    isSubsetOf(B, A).


% removeDuplicates(List, Result).
%  removes duplicates from the given list
%  essentially creates a set
removeDuplicates([], []).
removeDuplicates([H|T], [H|Result]) :-
    removeDuplicates(T, Result),
    not(member(H, Result)).
removeDuplicates([H|T], Result) :-
    removeDuplicates(T, Result),
    member(H, Result).




% Example problems with sets

/* Problem1:
    Define a predicate p1(L), where L is a list of lists,
    that checks whether or not for each pair of different
    lists in L there is a common element that's contained
    in both the lists and is not contained in at least
    on of the lists in L.
        /  Different brackets are used to help  /
        / identifying the corresponding bracket /
    Solution:
        (∀X∈L)(∀Y∈L) { X≠Y → (∃T∈X)( T∈Y & (∃Z∈L)(T∉Z) ) }
    Translated to prolog:
        ¬( (∃X∈L)(∃Y∈L) [ X≠Y & ¬(∃T∈X){ T∈Y & (∃Z∈L)(T∉Z) } ] )
*/
p1(L) :-
    not(( member(X, L),
          member(Y, L),
          X\=Y,
          not(( inIntersection(T, X, Y),
                member(Z, L),
                not(member(T, Z))
              ))
        )).




/* Problem2:
    Define a predicate p2(L), where L is a list of lists,
    that checks whether or not there is a pair of different
    lists in L that have a common element, contained in
    both the lists, such that it is not contained in any
    other list in L.
        /  Different brackets are used to help  /
        / identifying the corresponding bracket /
    Solution:
        (∃X∈L)(∃Y∈L) { X≠Y & (∃T∈X)[ T∈Y & (∀Z∈L)( Z≠X & Z≠Y → T∉Z ) ] }
    Translated to prolog:
        (∃X∈L)(∃Y∈L) { X≠Y & (∃T∈X)[ T∈Y & ¬(∃Z∈L)( Z≠X & Z≠Y & T∈Z ) ] }
*/
p2(L) :-
    member(X, L),
    member(Y, L),
    X\=Y,
    inIntersection(T, X, Y),
    not(( member(Z, L),
          Z\=X,
          Z\=Y,
          member(T, Z)
        )).




/* Problem3:
    Define a predicate p3(X, Y) that for a given list X
    generates in Y a list containing the elements of X such
    that the number of occurrences of the most occurring
    element in Y is a number that is not contained in X.
    Needed new predicates: subsequence, count, countMax
*/

% ex_subsequence(List, Result).
%  generates subsequences in result
ex_subsequence([], []).
ex_subsequence([X|T1], [X|T2]) :-
    ex_subsequence(T1, T2).
ex_subsequence([X|T1], [_|T2]) :-
    ex_subsequence([X|T1], T2).

% ex_genSubet(SubSet, List).
%  generates subsets from a list
ex_genSubset(S, L) :-
    ex_subsequence(Sub, L),
    permutation(Sub, S).

% ex_count(Element, NumOfOccurrences, List).
%  counts the number of occurrences of
%  an element in the given list
%  or checks the number of occurrences
ex_count(_, 0, []).
ex_count(Elem, N, [Elem|T]) :-
    ex_count(Elem, M, T),
    N is M+1.
ex_count(Elem, N, [H|T]) :-
    Elem\=H,
    ex_count(Elem, N, T).

% ex_countMax(Element, NumOfOccurrences, List).
%  returns the element with the most number
%  of occurrences in a given list and that
%  number of occurrences
ex_countMax(Elem, Num, List) :-
    member(Elem, List),
    ex_count(Elem, Num, List),
    not(( member(X, List),
          ex_count(X, NumOther, List),
          NumOther>Num
        )).

p3(X, Y) :-
    ex_genSubset(Y, X),
    ex_countMax(_, N, Y),
    not(member(N, X)).




/* Problem4:
    Define a predicate palindrome(L) that for a given list L
    checks whether or not it's a palindrome.
*/
palindrome([]).
palindrome([_]).
palindrome([H|T]) :-
    last(T, H),
    append(LastRemoved, [H], T),
    palindrome(LastRemoved).

