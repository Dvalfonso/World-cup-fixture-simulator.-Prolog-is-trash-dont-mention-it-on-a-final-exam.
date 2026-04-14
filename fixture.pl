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
%  2A vs 2B
%

sim(Grupo, GrupoDefinido) :- lista_de(Grupo, ListaGrupo), random_permutation(ListaGrupo, GrupoDefinido).


simular_grupos(GrupoADefinido, GrupoBDefinido, GrupoCDefinido, GrupoDDefinido, GrupoEDefinido, GrupoFDefinido, GrupoGDefinido, GrupoHDefinido, GrupoIDefinido, GrupoJDefinido, GrupoKDefinido, GrupoLDefinido) :- sim(grupoA, GrupoADefinido),
                            sim(grupoB, GrupoBDefinido),
                            sim(grupoC, GrupoCDefinido),
                            sim(grupoD, GrupoDDefinido),
                            sim(grupoE, GrupoEDefinido),
                            sim(grupoF, GrupoFDefinido),
                            sim(grupoG, GrupoGDefinido),
                            sim(grupoH, GrupoHDefinido),
                            sim(grupoI, GrupoIDefinido),
                            sim(grupoJ, GrupoJDefinido),
                            sim(grupoK, GrupoKDefinido),
                            sim(grupoL, GrupoLDefinido).


% Borrar para usar simular_grupos
dieciseisavos1(Grupo1, Grupo2, Ganador) :- lista_de(Grupo1, Lista1), 
                            lista_de(Grupo2, Lista2), 
                            random_permutation(Lista1, Grupo1Definido),
                            random_permutation(Lista2, Grupo2Definido),
                            segundo(Grupo1Definido, Segundo1),
                            segundo(Grupo2Definido, Segundo2),
                            elegir(Segundo1, Segundo2, Ganador).
