% Start Rules (Knowledge Base)
/* Knowledge Base */
game(blue_archive):-
    waifu_game(yes),
    gun_theme(yes),
    cunny(yes).
game(nikke):-
    waifu_game(yes),
    gun_theme(yes),
    cunny(no),
    idle_game(yes).
game(girls_frontline):-
    waifu_game(yes),
    gun_theme(yes),
    cunny(no),
    idle_game(no).
game(idolmaster_shiny_colors):-
    waifu_game(yes),
    gun_theme(no),
    idol_game(yes).
game(azur_lane):-
    waifu_game(yes),
    gun_theme(no),
    idol_game(no),
    idle_game(yes).
game(uma_musume_pretty_derby):-
    waifu_game(yes),
    gun_theme(no),
    idol_game(no),
    idle_game(no).
game(arknights):-
    waifu_game(no),
    kemonomimi(yes).
game(fate_grand_order):-
    waifu_game(no),
    kemonomimi(no),
    historical_characters(yes).
game(genshin_impact):-
    waifu_game(no),
    kemonomimi(no),
    historical_characters(no).
    % See Multivariate Cooperation

/* Characteristic rules */
waifu_game(X):-
    menuask(waifu_game, X, [yes, no]).
gun_theme(X):-
    menuask(gun_theme, X, [yes, no]).
kemonomimi(X):-
    menuask(kemonomimi, X, [yes, no]).
cunny(X):-
    menuask(cunny, X, [yes, no]).
idol_game(X):-
    menuask(idol_game, X, [yes, no]).
historical_characters(X):-
    menuask(historical_characters, X, [yes, no]).
idle_game(X):-
    menuask(idle_game, X, [yes, no]).

/* Menuask */
menuask(A, V, _MenuList):-
    known(A, yes, V), % succeed if true
    !. % stop looking
menuask(A, _V, _MenuList):-
    known(A, _, __), % fail if false
    !,
    fail.
menuask(A, V, MenuList) :-
    write('Do you like '), write(A), write('?'), nl,
    write(MenuList), nl,
    read(X),
    check_val(X, A, V, MenuList),
    asserta( known(A, yes, X) ),
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