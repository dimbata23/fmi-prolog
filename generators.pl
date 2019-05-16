% nat(N).
% natural number generator
nat(0).
nat(N) :-
    nat(M),
    N is M+1.


% after(A, N).
% natural number generator after A
after(A, N) :-
    nat(Z),
    N is Z+A.


% switchSign(X, Y).
%  generates Y, such that Y is either X or -X
switchSign(0, 0).
switchSign(X, Y) :-
    X>0,
    (   Y is X
    ;   Y is -X
    ).


% int(N).
%  integers generator
int(Z) :-
    nat(N),
    switchSign(N, Z).


% isEven(Num).
%  checks whether or not the given number is even
isEven(Num) :-
    0 is Num mod 2.


% isOdd(Num).
%  checks whether or not the given number is Odd
isOdd(Num) :-
    \+ isEven(Num).


% gcd(Num1, Num2, GCD).
%  checks/calculates the greates common divisor
gcd(X, 0, X).
gcd(0, X, X).
gcd(X, Y, Y) :-
    X>0,
    Y>0,
    0 is X mod Y.
gcd(X, Y, GCD) :-
    X>0,
    Y>0,
    R is X mod Y,
    gcd(Y, R, GCD).


% fibbonacci(X).
%  fibonacci numbers generator
fibbonacci(X) :-
    fib(X, 0, 1).
fib(X, X, _).
fib(X, Y, Z) :-
    Next is Y+Z,
    fib(X, Next, Y).


% isPrime(X).
%  checks whether or not a number is prime
isPrime(X) :-
    X>0,
    X1 is sqrt(X),
    not(( between(2, X1, Curr),
          0 is X mod Curr
        )).


% genPrime(X).
%  generates prime numbers
genPrime(X) :-
    nat(X),
    isPrime(X).


% genPrimeAfter(A, Prime).
%  generates prime numbers after A
genPrimeAfter(A, X) :-
    after(A, X),
    isPrime(X).


% between(A, B, Number).
%  generates the numbers from A to B
between(A, B, A) :-
    A=<B.
between(A, B, C) :-
    Curr is A+1,
    A<B,
    between(Curr, B, C).


% pair(X, Y).
%  generates pairs of natural numbers
pair(X, Y) :-
    nat(N),
    between(0, N, X),
    Y is N-X.


% genKS(K, Sum, ListOfNums).
%  generates K numbers in ListOfNums
%  such that their sum is equal to Sum
genKS(1, S, [S]).
genKS(K, S, [Curr|Result]) :-
    K>1,
    between(0, S, Curr),
    S1 is S-Curr,
    K1 is K-1,
    genKS(K1, S1, Result).
