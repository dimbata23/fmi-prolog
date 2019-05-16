/*
    G = [ V, E ]
    V = [ a, b, c, ... ]
    E = [ [a,b], [c,d], ...]
*/

% simplePath([V, E], X, Y, Path).
%  generates a simple path from X to Y
simplePath([_, E], X, Y, Path) :-
    sp(E, X, Y, [X], Path).
sp(_, Target, Target, Vis, Vis).
sp(E, Curr, Target, Vis, Path) :-
    Curr\=Target,
    member([Curr, Next], E),
    \+ member(Next, Vis),
    append(Vis, [Next], Vis1),
    sp(E, Next, Target, Vis1, Path).


% simplePath2([V, E], X, Y, Path).
%  generates a simple path from X to Y
simplePath2([_, E], X, Y, Path) :-
    sp2(E, X, [Y], Path).
sp2(_, X, [X|Rest], [X|Rest]).
sp2(E, X, [Z|Rest], Path) :-
    X\=Z,
    member([W, Z], E),
    \+ member(W, [Z|Rest]),
    sp2(E, X, [W, Z|Rest], Path).


% isConnectedGraph([V, E]).
%  checks wheter or not the given undirected graph is connected
isConnectedGraph([V, E]) :-
    not(( member(X, V),
          member(Y, V),
          X\=Y,
          \+ simplePath([V, E], X, Y, _)
        )).


% isCompleteGraph([V, E]).
%  checks wheter or not the given graph is complete
isCompleteGraph([V, E]) :-
    not(( member(X, V),
          member(Y, V),
          X\=Y,
          \+ member([X, Y], E)
        )).


% isUndirectedGraph([V, E]).
%  checks wheter or not the given graph is undirected
isUndirectedGraph([_, E]) :-
    not(( member([X, Y], E),
          \+ member([Y, X], E)
        )).


% isMultiGraph([V, E]).
%  checks wheter or not the given graph is a multigraph
isMultiGraph([_, E]) :-
    select(Edge, E, NE),
    member(Edge, NE).


% isCriticalVertex([V, E], Vertex).
%  checks whether or not the given vertex is critical
%  (only suitable for undirected graphs!)
isCriticalVertex([V, E], Vertex) :-
    select(Vertex, V, NewV),
    \+ isCompleteGraph([NewV, E]).


% hasCycle([V, E], Cycle).
%  returns the cycles in the graph
hasCycle([_, E], [X]) :-
    member([X, X], E).
hasCycle([V, E], [X|P]) :-
    isUndirectedGraph([V, E]),
    member([X, Y], E),
    X\=Y,
    simplePath([V, E], Y, X, P),
    length(P, L),
    L>=3.
hasCycle([V, E], [X|P]) :-
    \+ isUndirectedGraph([V, E]),
    member([X, Y], E),
    X\=Y,
    simplePath([V, E], Y, X, P),
    length(P, L),
    L>=2.


% dfs([V, E], Root, Result).
%  traversing the graph using Depth First Search
%  keeping the path taken in Result
dfs([_, E], Root, Result) :-
    dfsH(E, [Root], [], Result).
dfsH(_, [], _, []).
dfsH(E, [StackH|StackT], Visited, [[StackH, Next]|Result]) :-
    genNext(E, StackH, [StackH|StackT], Visited, Next),
    dfsH(E, [Next, StackH|StackT], Visited, Result).
dfsH(E, [StackH|StackT], Visited, Result) :-
    \+ genNext(E,
               StackH,
               [StackH|StackT],
               Visited,
               _),
    dfsH(E, StackT, [StackH|Visited], Result).
genNext(E, Current, Stack, Visited, Next) :-
    member([Current, Next], E),
    \+ member(Next, Stack),
    \+ member(Next, Visited).


% bfs([V, E], Root, Result).
%  traversing the graph using Breadth First Search
%  keeping the path taken in Result
bfs([_, E], Root, Result) :-
    bfsH(E, [Root], [], Result).
bfsH(_, [], _, []).
bfsH(E, [QueueH|QueueT], Visited, [[QueueH, Next]|Result]) :-
    genNext(E, QueueH, [QueueH|QueueT], Visited, Next),
    append([QueueH|QueueT], [Next], NewQueue),
    bfsH(E, NewQueue, Visited, Result).
bfsH(E, [QueueH|QueueT], Visited, Result) :-
    \+ genNext(E,
               QueueH,
               [QueueH|QueueT],
               Visited,
               _),
    bfsH(E, QueueT, [QueueH|Visited], Result).


% hamiltonianPath([V, E], Path).
%  a brute force approach to generate
%  a hamiltonian path (if such exists)
hamiltonianPath([V, E], Path) :-
    permutation(V, Path),
    not(( append(_, [X, Y|_], Path),
          not(member([X, Y], E))
        )).


% clique([V, E], Clique)
%  generates cliques from the graph
clique([V, E], Clique) :-
    ex_genSubset(Clique, V),
    isCompleteGraph([Clique, E]).

% ex_subsequence(List, Result).
%  generates subsequences in result
ex_subsequence([], _).
ex_subsequence([X|T1], [X|T2]) :-
    ex_subsequence(T1, T2).
ex_subsequence([X|T1], [_|T2]) :-
    ex_subsequence([X|T1], T2).

% ex_genSubet(SubSet, List).
%  generates subsets from a list
ex_genSubset(S, L) :-
    ex_subsequence(Sub, L),
    permutation(Sub, S).


% maxClique([V, E], Clique, Vertices).
%  generates max cliques from the graph
maxClique([V, E], Clique, NumVertices) :-
    clique([V, E], Clique),
    length(Clique, NumVertices),
    not(( clique([V, E], OtherClique),
          length(OtherClique, OtherNumVertices),
          OtherNumVertices>NumVertices
        )).
