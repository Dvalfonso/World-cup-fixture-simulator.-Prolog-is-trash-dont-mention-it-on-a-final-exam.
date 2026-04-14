:- use_module(library(random)).

grupoA(mexico).
grupoA(sudafrica).
grupoA(corea).
grupoA(chequia).

grupoB(canada).
grupoB(bosnia).
grupoB(qatar).
grupoB(suiza).

grupoC(brasil).
grupoC(marruecos).
grupoC(haiti).
grupoC(escocia).

grupoD(usa).
grupoD(paraguay).
grupoD(australia).
grupoD(turquia).

grupoE(alemania).
grupoE(curazao).
grupoE(cmarfil).
grupoE(ecuador).

grupoF(pbajos).
grupoF(japon).
grupoF(suecia).
grupoF(tunez).

grupoG(belgica).
grupoG(egipto).
grupoG(iran).
grupoG(nzelanda).

grupoH(españa).
grupoH(cverde).
grupoH(sarabia).
grupoH(uruguay).

grupoI(francia).
grupoI(senegal).
grupoI(iraq).
grupoI(noruega).


grupoJ(argentina).
grupoJ(argelia).
grupoJ(austria).
grupoJ(jordania).


grupoK(portugal).
grupoK(congo).
grupoK(uzbekistan).
grupoK(colombia).

grupoL(inglaterra).
grupoL(croacia).
grupoL(ghana).
grupoL(panama).

% predicados utiles

% predicado generico que recibe otro predicado por ejemplo grupoA y te devuelve la lista de argumentos para los cuales grupoA(X) es true
% si en el interprete hacer por ejempl grupoA(X) te devuelve el primero que encuentra y no sigue el backtracking salvo que se lo especifiques
lista_de(Predicado, Lista) :- findall(X, call(Predicado, X), Lista).

% predicados que devuelven un elemento particular de una lista
primero([X|_], X).
segundo([_,X,_,_], X).
tercero([_,_,X,_], X).
cuarto([_,_,_,X], X).

% elige uno entre dos elementos. Simula enfrentamientos directos
elegir(A, B, X) :- random_member(X, [A,B]).

% random_permutation mezcla las listas para simular que se jugaron partidos
dieciseisavos1(Ganador) :- lista_de(grupoA, ListaA), 
                            lista_de(grupoB, ListaB), 
                            random_permutation(ListaA, GrupoADefinido),
                            random_permutation(ListaB, GrupoBDefinido),
                            segundo(GrupoADefinido, SegundoA),
                            segundo(GrupoBDefinido, SegundoB),
                            elegir(SegundoA, SegundoB, Ganador).
