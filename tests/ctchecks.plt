:- multifile
    user:message_property/2.

:- dynamic
    user:error_on_co/0.

user:message_property(_, stream(current_output)) :- user:error_on_co.

:- use_module(library(swi/ctchecks)).

:- use_module(comment_data).

:- begin_tests(ctchecks).

:- comment_data:enable.

/* $ctcex$
ERROR: In assertions for [ctcex:a/2]
ERROR: ctcex.pl:11: Compile-Time failure in assertion for ctcex:a(a,b).
ERROR: 	In *compat*, unsatisfied properties: 
ERROR: 		[int(a),list(b)].
ERROR: ctcex.pl:14:0: Failed in ctcex:a(a,b).
ERROR: In assertions for [ctcex:a/2]
ERROR: ctcex.pl:11: Compile-Time failure in assertion for ctcex:a(1,b).
ERROR: 	In *compat*, unsatisfied properties: 
ERROR: 		[list(b)].
ERROR: ctcex.pl:17:4: Failed in ctcex:a(1,b).
*/

test(ctcex) :-
    %set_prolog_flag(check_assertions, [defined, is_prop, ctcheck]),
    set_prolog_flag(verbose, silent),
    assert(user:error_on_co),
    with_output_to(string(Result), [ctcex]),
    comment_data(ctcex, Pattern),
    assertion(Pattern == Result),
    set_prolog_flag(verbose, normal),
    %set_prolog_flag(check_assertions, []).
    retractall(user:error_on_co).

:- comment_data:disable.

:- end_tests(ctchecks).