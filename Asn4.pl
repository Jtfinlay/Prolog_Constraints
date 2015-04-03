% James Finlay
% CMPUT 325 - LEC B1
% Assignment # 3

:- use_module(library(clpfd)).
:- use_module(library(lists)).

insert_data :-
    assert(c325(fall_2014,aperf,15,15,15,15,79,99)),
    assert(c325(fall_2014,john,14,13,15,10,76,87)),
    assert(c325(fall_2014,lily, 9,12,14,14,76,92)),
    assert(c325(fall_2014,peter,8,13,12,9,56,58)),
    assert(c325(fall_2014,ann,14,15,15,14,76,95)),
    assert(c325(fall_2014,ken,11,12,13,14,54,87)),
    assert(c325(fall_2014,kris,13,10,9,7,60,80)),
    assert(c325(fall_2014,audrey,10,13,15,11,70,80)),
    assert(c325(fall_2014,randy,14,13,11,9,67,76)),
    assert(c325(fall_2014,david,15,15,11,12,66,76)),
    assert(c325(fall_2014,sam,10,13,10,15,65,67)),
    assert(c325(fall_2014,kim,14,13,12,11,68,78)),
    assert(c325(fall_2014,perf,15,15,15,15,80,100)),
    assert(c325(winter_2014,aperf,15,15,15,15,80,99)),
    assert(setup(fall_2014,as1,15,0.1)),
    assert(setup(fall_2014,as2,15,0.1)),
    assert(setup(fall_2014,as3,15,0.1)),
    assert(setup(fall_2014,as4,15,0.1)),
    assert(setup(fall_2014,midterm,80,0.25)),
    assert(setup(fall_2014,final,100,0.35)).

%*******************************************************************
% Q1a **************************************************************
% query1(+Semester,+Name, -Total) : Given a semester and a student 
% name, Total should be bound to the total mark, in terms of 
% percentage, of the student for that semester.

query1(Semester,Name,Total) :-
    c325(Semester,Name,As1,As2,As3,As4,Midterm,Final),
    setup(Semester,as1,M1,W1),
    setup(Semester,as2,M2,W2),
    setup(Semester,as3,M3,W3),
    setup(Semester,as4,M4,W4),
    setup(Semester,midterm,MM,WM),
    setup(Semester,final,MF,WF), !,
    Total is (As1/M1)*W1 + (As2/M2)*W2 + (As3/M3)*W3 
        + (As4/M4)*W4 + (Midterm/MM)*WM + (Final/MF)*WF.

%*******************************************************************
% Q1b **************************************************************
% query2(+Semester,-L) : Given a semester, find all students whose
% final exam shows an improvement over the midterm, in the sense
% that the percentage obtained from the final is (strictly) better
% than that of the midterm.

query2(Semester, L) :-
    findall(X, c325(Semester,X,_,_,_,_,_,_), L1),
    !, constraint2(Semester, L2, L).

constraint2(_,[],[]).
constraint2(Semester, [H|T], [H|R]) :-
    c325(Semester,H,_,_,_,_,M,F),
    setup(Semester,midterm,MM,_),
    setup(Semester,final,MF,_),
    (F/MF) > (M/MM), !,
    constraint2(Semester,T,R).
constraint2(Semester,[H|T],R) :- !, constraint2(Semester,T,R).

%*******************************************************************
% Q1c **************************************************************
% query3(+Semester,+Name,+Type,+NewMark) : Updates the record of
% Name for Semester where Type gets NewMark. If the record is not
% in the database, print the message "record not found".

query3(Semester,Name,Type,NewMark) :-
    member(Type,[as1,as2,as3,as4,midterm,final]),
    c325(Semester,Name,A1,A2,A3,A4,Mid,Fin),
    (Type == as1 -> A1f=NewMark ; A1f=A1),
    (Type == as2 -> A2f=NewMark ; A2f=A2),
    (Type == as3 -> A3f=NewMark ; A3f=A3),
    (Type == as4 -> A4f=NewMark ; A4f=A4),
    (Type == midterm -> Midf=NewMark ; Midf=Mid),
    (Type == final -> Finf=NewMark ; Finf=Fin),
    retract(c325(Semester,Name,A1,A2,A3,A4,Mid,Fin)),
    assert(c325(Semester,Name,A1f,A2f,A3f,A4f,Midf,Finf)).
query3(_,_,_,_) :- print('record not found').

%*******************************************************************
% Q2 ***************************************************************
% schedule(-TimeLst,-RmList) :  

insert_data2 :-
    assert(room(r1)),
    assert(room(r2)),
    assert(room(r3)),
    assert(room(r4)),
    assert(notAtSameTime([b,c,k])),
    assert(before(k,f)),
    assert(before(c,d)),
    assert(at(a,_,r2)),
    assert(at(d,_,r4)).

schedule(TimeList,RmList) :-
    TimeList = [A,B,C,D,E,F,G,H,I,J,K],
    length(TimeList,Len),
    length(RmList,Len),                 
    append(TimeList, RmList, W),

    findall(Rn, room(Rn), RL), length(RL,RLen),
    findall(L, notAtSameTime(L), C1),
    findall([Q1,Q2],before(Q1,Q2), C2),
    findall([Session,Time,Rm],at(Session,Time,Rm), C3i),
    mapC3(C3i, RL, C3),

    domain(TimeList, 1, 4),
    domain(RmList, 1, RLen),

    constr1(TimeList,C1),
    constr2(TimeList,C2),
    constr3(TimeList,RmList,C3),
    exclusive(TimeList,RmList),
    
    labeling([],W),

    List = [a,b,c,d,e,f,g,h,i,j,k],
    myPrint(TimeList,RmList,List). 

schedule(_,_) :- write('cannot be scheduled').

myPrint([],[],[]). 
myPrint([T|L],[W|R],[List|Rest]):- 
    write('session '), write(List), write(' at time '), 
    write(T), write(' in room '), write(W), write('\n'), 
    myPrint(L,R,Rest).

%*******************************************************************
% constr1(+TimeList, +C1) :- Satisfy all "notAtSameTime constraints"

constr1(_,[]).
constr1(L, [H|C]) :-
    Tmp = [a,b,c,d,e,f,g,h,i,j,k],
    map_index(H,Tmp,I),
    map_values(I,L,V),
    unique_r(V),
    constr1(L,C).

unique_r([]).
unique_r([H|T]) :-
    unique(H,T),
    unique_r(T).

unique(_,[]).
unique(E,[H|T]) :-
    E #\= H,
    unique(E,T).


%*******************************************************************
% constr2(+TimeList, +C2) :- Satisfy all "before constraints"
constr2(_,[]).
constr2(L, [H|C]) :-
    Tmp = [a,b,c,d,e,f,g,h,i,j,k],
    map_index(H,Tmp,I),
    map_values(I,L,[A,B]),
    A #< B,
    constr2(L,C).

%*******************************************************************
% constr3(+TimeLst, +RmList, +C3) :- Satisfy all "at constraints"
constr3(_,_,[]).
constr3(TL,RL,[HC|TC]) :-
    constr3_rooms(RL,HC),
    constr3_times(TL,HC),
    constr3(TL,RL,TC).

% constr3_rooms(+RoomList,+Constraint) :- Satisfy room constraint
constr3_rooms(L,[S,_,R]) :-
    Tmp = [a,b,c,d,e,f,g,h,i,j,k],
    indexOf(S,Tmp,I),
    nth0(I,L,V),
    V #= R.

% constr3_times(+TimeList,+Constraint) :- Satisfy time constraint
constr3_times(L,[S,T,_]) :-
    Sessions = [a,b,c,d,e,f,g,h,i,j,k],
    indexOf(S,Sessions,IS),
    nth0(IS,L,V),

    Times = [firstDayAm,firstDayPm,secondDayAm,secondDayPm],
    indexOf(T,Times,IT),

    V #= IT.

% mapC3(C3i, RL, C3) : 
mapC3([],_,[]).
mapC3([[A,B,E]|T], RL, [[A,B,I]|R]) :-
    indexOf(E,RL,Ii),
    I is Ii+1,
    mapC3(T,RL,R).

%*******************************************************************
% map_index(+Values,+List,-Indices) : remap all 'Values' to their positions in 'List'
map_index([],_,[]).
map_index([H|T],L,[I|R]) :-
    indexOf(H,L,I),
    map_index(T,L,R).

% map_values(+Indicies,+List,-Values) : remap all 'Indicies' to their values in 'List'
map_values([],_,[]).
map_values([H|T],L,[V|R]) :-
    nth0(H,L,V),
    map_values(T,L,R).

% indexOf(+Value,+List,-Index) : determine the index of value in list
indexOf(E,[E|_],0) :- !.
indexOf(V,[_|T],Index) :-
    indexOf(V,T,Index1),
    !,
    Index is Index1+1.

%*******************************************************************
% Ensure no A value is allocated twice for each B

exclusive(A,B) :-
    zip(A,B,Z),
    runique_pairs(Z).

runique_pairs([]).
runique_pairs([H|T]) :-
    unique_pairs(H,T),
    runique_pairs(T).

unique_pairs(_,[]).
unique_pairs([E1,E2],[[H1,H2]|T]) :-
    (E1 #\= H1 #\/ E2 #\= H2),
    unique_pairs([E1,E2],T).

zip([],[],[]).
zip([X|Xs], [Y|Ys], [[X,Y]|Zs]) :- zip(Xs,Ys,Zs).


%*******************************************************************
% Q3 ***************************************************************
% subsetSum(+L,-Result) : 

subsetSum(L,Result) :-
    length(L, Len),
    length(B, Len),

    domain(B,0,1),
    
    pullValues(B,L,V),
    constrainMax(V),
    constrainEmpty(B),

    labeling([],V),

    pullValues(B,L,Result).

pullValues([],[],[]).
pullValues([0|BT],[_|LT],R) :- pullValues(BT,LT,R).
pullValues([1|BT],[LH|LT],[LH|R]) :- pullValues(BT,LT,R).

constrainMax(V) :-
    sum(V,R),
    R #= 0.

constrainEmpty(B) :-
    sum(B,R),
    R #\= 0.

sum([],0).
sum([H|T],R) :-
    sum(T,R1),
    R is H+R1.








