% James Finlay
% CMPUT 325 - LEC B1
% Assignment # 3

:- use_module(library(clpfd)).

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

%******************************************************************
% rmDup(+L, -R): Remove duplicates from the given list.

rmDup([],[]).
rmDup([H|T],R) :- member(H,T), rmDup(T,R).
rmDup([H|T],[H|R]) :- rmDup(T,R).

% Q1a **************************************************************
% query1(+Semester,+Name, -Total) : Given a semester and a student 
% name, Total should be bound to the total mark, in terms of 
% percentage, of the student for that semester.

query1(Semester,Name,Total) :-
    insert_data,
    c325(Semester,Name,As1,As2,As3,As4,Midterm,Final),
    setup(Semester,as1,M1,W1),
    setup(Semester,as2,M2,W2),
    setup(Semester,as3,M3,W3),
    setup(Semester,as4,M4,W4),
    setup(Semester,midterm,MM,WM),
    setup(Semester,final,MF,WF), !,
    Total is (As1/M1)*W1 + (As2/M2)*W2 + (As3/M3)*W3 
        + (As4/M4)*W4 + (Midterm/MM)*WM + (Final/MF)*WF.


% Q1b **************************************************************
% query2(+Semester,-L) : Given a semester, find all students whose
% final exam shows an improvement over the midterm, in the sense
% that the percentage obtained from the final is (strictly) better
% than that of the midterm.

query2(Semester, L) :-
    insert_data,
    findall(X, c325(Semester,X,_,_,_,_,_,_), L1),
    rmDup(L1,L2), !,
    constraint2(Semester, L2, L).

constraint2(_,[],[]).
constraint2(Semester, [H|T], [H|R]) :-
    c325(Semester,H,_,_,_,_,M,F),
    setup(Semester,midterm,MM,_),
    setup(Semester,final,MF,_),
    (F/MF) > (M/MM), !,
    constraint2(Semester,T,R).
constraint2(Semester,[H|T],R) :- !, constraint2(Semester,T,R).

% Q1c **************************************************************
% query3(+Semester,+Name,+Type,+NewMark) : Updates the record of
% Name for Semester where Type gets NewMark. If the record is not
% in the database, print the message "record not found".

query3(Semester,Name,Type,NewMark) :-
    member(Type,[as1,as2,as3,as4,midterm,final]),
    insert_data,
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
