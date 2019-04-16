
% ex_length(List, Len).
% returns the length of a list.
ex_length([], 0).
ex_length([_|T], N) :- length(T, M), N is M+1.


% ex_reverse(List, ReversedList).
% creates a reversed list.
ex_reverse(List, RevList) :- ex_reverse(List, RevList, []).
ex_reverse([], Buff, Buff).
ex_reverse([H|T], R, Acc) :- ex_reverse(T, R, [H|Acc]).


% ex_append(List, LatterList, ResultList).
% ...
ex_append([], List, List).
ex_append([H|T], List, [H|Tn]) :- ex_append(T, List, Tn).
