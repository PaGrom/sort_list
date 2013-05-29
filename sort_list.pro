sort_list([], []).
sort_list(List, [Min|SortRest]) :- 
	min_list_exclude(Min, List, Exclude),
	sort_list(Exclude, SortRest).

%% Рекурсивно исключаем минимальное число, если в списке одно число, исключаем его
min_list_exclude(M, [M], []).
min_list_exclude(Min, [M|L], ExcludeRes) :- 
	min_list_exclude(Ms, L, Exclude),
	find_result(result(M, L), 
	result(Ms, [M|Exclude]), 
	result(Min, ExcludeRes)).

%% Дополнительный предикат для определения пары с минимальным ключом
find_result(result(M, L), result(Ms, _), result(M, L)) :- M < Ms.
find_result(result(M, _), result(Ms, Exclude), result(Ms, Exclude)) :- Ms =< M.

:- initialization(main).

%% Предикат для преобразования строки в число
str2int([], []).
str2int([S|St], [N|Nt]) :- 
	number_atom(N, S),
	str2int(St, Nt).

main :-
	argument_list(Args),
	str2int(Args, List),
	sort_list(List, SortedList),
	write(SortedList), nl.
