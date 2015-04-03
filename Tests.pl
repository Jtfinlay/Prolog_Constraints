


%*******************************************************************
%*************************** Q1 DATA *******************************
%*******************************************************************

insert_data1 :-
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

retract_data1 :-
    retract(c325(fall_2014,aperf,15,15,15,15,79,99)),
    retract(c325(fall_2014,john,14,13,15,10,76,87)),
    retract(c325(fall_2014,lily, 9,12,14,14,76,92)),
    retract(c325(fall_2014,peter,8,13,12,9,56,58)),
    retract(c325(fall_2014,ann,14,15,15,14,76,95)),
    retract(c325(fall_2014,ken,11,12,13,14,54,87)),
    retract(c325(fall_2014,kris,13,10,9,7,60,80)),
    retract(c325(fall_2014,audrey,10,13,15,11,70,80)),
    retract(c325(fall_2014,randy,14,13,11,9,67,76)),
    retract(c325(fall_2014,david,15,15,11,12,66,76)),
    retract(c325(fall_2014,sam,10,13,10,15,65,67)),
    retract(c325(fall_2014,kim,14,13,12,11,68,78)),
    retract(c325(fall_2014,perf,15,15,15,15,80,100)),
    retract(c325(winter_2014,aperf,15,15,15,15,80,99)),
    retract(setup(fall_2014,as1,15,0.1)),
    retract(setup(fall_2014,as2,15,0.1)),
    retract(setup(fall_2014,as3,15,0.1)),
    retract(setup(fall_2014,as4,15,0.1)),
    retract(setup(fall_2014,midterm,80,0.25)),
    retract(setup(fall_2014,final,100,0.35)).

%*******************************************************************
%*************************** Q2 TESTS ******************************
%*******************************************************************

% The following tests were provided by the TAs.

test3_1 :-
    assert(room(r1)),
    assert(room(r2)),
    assert(room(r3)),
    assert(notAtSameTime([b,i,h,g])),
    assert(before(i,j)),
    assert(at(a,_,r2)),

    (schedule(T,R);true),

    retract(room(r1)),
    retract(room(r2)),
    retract(room(r3)),
    retract(notAtSameTime([b,i,h,g])),
    retract(before(i,j)),
    retract(at(a,_,r2)).

test3_2 :-
    assert(room(r1)),
    assert(room(r2)),
    assert(room(r3)),
    assert(room(r4)),
    assert(notAtSameTime([b,c,k])),
    assert(before(k,f)),
    assert(before(c,d)),
    assert(at(a,_,r2)),
    assert(at(d,_,r4)),

    (schedule(T,R);true),

    retract(room(r1)),
    retract(room(r2)),
    retract(room(r3)),
    retract(room(r4)),
    retract(notAtSameTime([b,c,k])),
    retract(before(k,f)),
    retract(before(c,d)),
    retract(at(a,_,r2)),
    retract(at(d,_,r4)).

test3_3 :-
    assert(room(r1)),
    assert(room(r2)),
    assert(room(r3)),
    assert(room(r4)),
    assert(notAtSameTime([b,g,k])),
    assert(before(k,f)),
    assert(before(c,d)),
    assert(at(a,firstDayPm,_)),
    assert(at(d,_,r4)),

    (schedule(T,R);true),

    retract(room(r1)),
    retract(room(r2)),
    retract(room(r3)),
    retract(room(r4)),
    retract(notAtSameTime([b,g,k])),
    retract(before(k,f)),
    retract(before(c,d)),
    retract(at(a,firstDayPm,_)),
    retract(at(d,_,r4)).

test3_4 :-
    assert(room(r1)),
    assert(room(r2)),
    assert(room(r3)),
    assert(room(r4)),
    assert(room(r5)),
    assert(notAtSameTime([d,g,h,k])),
    assert(notAtSameTime([a,c])),
    assert(before(k,d)),
    assert(before(d,j)),
    assert(at(a,_,r2)),
    assert(at(c,_,r3)),

    (schedule(T,R);true),

    retract(room(r1)),
    retract(room(r2)),
    retract(room(r3)),
    retract(room(r4)),
    retract(room(r5)),
    retract(notAtSameTime([d,g,h,k])),
    retract(notAtSameTime([a,c])),
    retract(before(k,d)),
    retract(before(d,j)),
    retract(at(a,_,r2)),
    retract(at(c,_,r3)).

test3_5 :-
    assert(room(r1)),
    assert(room(r2)),
    assert(room(r3)),
    assert(room(r4)),
    assert(room(r5)),
    assert(notAtSameTime([e,f,i,j])),
    assert(before(f,j)),
    assert(before(j,d)),
    assert(before(d,f)),
    assert(at(f,_,r4)),

    (schedule(T,R);true),

    retract(room(r1)),
    retract(room(r2)),
    retract(room(r3)),
    retract(room(r4)),
    retract(room(r5)),
    retract(notAtSameTime([e,f,i,j])),
    retract(before(f,j)),
    retract(before(j,d)),
    retract(before(d,f)),
    retract(at(f,_,r4)).

test3_6 :-
    assert(room(r1)),
    assert(room(r2)),
    assert(room(r3)),
    assert(room(r4)),
    assert(room(r5)),
    assert(room(r6)),
    assert(notAtSameTime([e,f,i,j])),
    assert(notAtSameTime([d,c,k])),
    assert(before(f,j)),
    assert(before(k,d)),
    assert(at(a,_,r6)),
    assert(at(f,_,r4)),
    assert(at(g,_,r1)),

    (schedule(T,R);true),

    retract(room(r1)),
    retract(room(r2)),
    retract(room(r3)),
    retract(room(r4)),
    retract(room(r5)),
    retract(room(r6)),
    retract(notAtSameTime([e,f,i,j])),
    retract(notAtSameTime([d,c,k])),
    retract(before(f,j)),
    retract(before(k,d)),
    retract(at(a,_,r6)),
    retract(at(f,_,r4)),
    retract(at(g,_,r1)).


test3_7 :-
    assert(room(r1)),
    assert(room(r2)),
    assert(room(r3)),
    assert(room(r4)),
    assert(room(r5)),
    assert(notAtSameTime([d,h,k])),
    assert(notAtSameTime([a,b,g])),
    assert(before(k,d)),
    assert(before(d,j)),
    assert(at(a,_,r2)),
    assert(at(c,secondDayPm, r4)),

    schedule(R,T),

    retract(room(r1)),
    retract(room(r2)),
    retract(room(r3)),
    retract(room(r4)),
    retract(room(r5)),
    retract(notAtSameTime([d,h,k])),
    retract(notAtSameTime([a,b,g])),
    retract(before(k,d)),
    retract(before(d,j)),
    retract(at(a,_,r2)),
    retract(at(c,secondDayPm, r4)).