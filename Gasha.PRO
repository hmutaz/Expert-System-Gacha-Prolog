% Start Rules (Knowledge Base)
/* Knowledge Base */
game(genshin_impact):-
    collect_characters(yes),
    strong_storyline(yes),
    anime_graphics(yes),
    fast_paced_gameplay(no),
    free_to_play(yes),
    single_player(yes),
    casual_gameplay(yes).
game(fate_grand_order):-
    collect_characters(yes),
    strong_storyline(yes),
    anime_graphics(yes),
    strategic_gameplay(yes),
    pay_to_play(yes),
    multiplayer(yes),
    competitive_gameplay(yes).
game(honkai_impact_3):-
    collect_characters(yes),
    strong_storyline(no),
    anime_graphics(yes),
    fast_paced_gameplay(yes),
    free_to_play(yes),
    multiplayer(yes),
    competitive_gameplay(yes).
game(azur_lane):-
    collect_characters(yes),
    strong_storyline(no),
    anime_graphics(yes),
    fast_paced_gameplay(yes),
    free_to_play(yes),
    multiplayer(yes),
    casual_gameplay(yes).
game(arknights):-
    collect_characters(yes),
    strong_storyline(no),
    realistic_graphics(yes),
    strategic_gameplay(yes),
    pay_to_play(no),
    single_player(yes),
    competitive_gameplay(no).
game(guardian_tales):-
    collect_characters(yes),
    strong_storyline(yes),
    realistic_graphics(no),
    strategic_gameplay(yes),
    free_to_play(yes),
    single_player(yes),
    casual_gameplay(yes).

/* Characteristic rules */
collect_characters(X):-
    menuask(collect_characters, X, [yes, no]).
strong_storyline(X):-
    menuask(strong_storyline, X, [yes, no]).
anime_graphics(X):-
    menuask(anime_graphics, X, [yes, no]).
realistic_graphics(X):-
    menuask(realistic_graphics, X, [yes, no]).
fast_paced_gameplay(X):-
    menuask(fast_paced_gameplay, X, [yes, no]).
strategic_gameplay(X):-
    menuask(strategic_gameplay, X, [yes, no]).
free_to_play(X):-
    menuask(free_to_play, X, [yes, no]).
pay_to_play(X):-
    menuask(pay_to_play, X, [yes, no]).
single_player(X):-
    menuask(single_player, X, [yes, no]).
multiplayer(X):-
    menuask(multiplayer, X, [yes, no]).
competitive_gameplay(X):-
    menuask(competitive_gameplay, X, [yes, no]).
casual_gameplay(X):-
    menuask(casual_gameplay, X, [yes, no]).

/* Menuask */
menuask(A, V, _) :-
    known(yes, A, V), % succeed if true
    !.
menuask(A, V, _) :-
    known(_, A, V), 
    !, fail. % fail if false
menuask(A, V, MenuList) :-
    write('Do you prefer '), write(A), write('? '), nl,
    write(MenuList), nl,
    write('Please answer yes or no.'), nl,
    read(X),
    check_val(X, A, V, MenuList),
    asserta(known(yes, A, V)),
    X == V.

/* Check input */
check_val(X, _A, _V, MenuList) :-
    member(X, MenuList), !.
check_val(X, A, V, MenuList) :-
    write(X), write(' is not a legal value, try again.'), nl,
    menuask(A, V, MenuList). 

/* Member rules */
member(X, [X|_]).
member(X, [_|T]) :-
    member(X, T).
% End User Interface

% Start Simple Shell
/* Simple Shell */
top_goal(X) :- game(X).

solve :-
    abolish(known, 3),
    top_goal(X),
    write('You should play '), write(X), nl.
solve :-
    write('You should touch the grass.'), nl.

go :-
    greeting,
    repeat,
    write('> '),
    read(X),
    do(X),
    X == quit.

greeting :-
    write('Welcome to the Gacha Game Recommender System!'), nl,
    write('Please answer the following questions to find the best game for you.'), nl.

/* Running Program */
do(start) :-
    solve,
    !.

/* Quit Program */
do(quit).
do(X) :-
    write(X),
    write(' is not a valid command.'), nl,
    fail.

% End Simple Shell

/* handle undefined procedure */
:- unknown(trace, fail).