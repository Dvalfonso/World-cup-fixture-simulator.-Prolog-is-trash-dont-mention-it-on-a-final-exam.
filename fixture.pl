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


% Simula cruces de 16avos
dieciseisavos(Ganadores16Avos) :- 
                            simular_grupos(GA, GB, GC, GD, GE, GF, GG, GH, GI, GJ, GK, GL),
                            %primer cruce
                            segundo(GA, SegundoA),
                            segundo(GB, SegundoB),
                            elegir(SegundoA, SegundoB, Ganador1),
                            %segundo cruce
                            primero(GE, PrimeroE),
                            tercero(GC, Tercero1),% Elijo uno para hacerlo menos complejo
                            elegir(PrimeroE, Tercero1, Ganador2),
                            %tercer cruce
                            primero(GF, PrimeroF),
                            segundo(GC, SegundoC),
                            elegir(PrimeroF, SegundoC, Ganador3),
                            %cuarto cruce
                            primero(GC, PrimeroC),
                            segundo(GF, SegundoF),
                            elegir(PrimeroC, SegundoF, Ganador4),
                            %quinto cruce
                            primero(GI, PrimeroI),
                            tercero(GE, Tercero2),%%%%
                            elegir(PrimeroI, Tercero2, Ganador5),
                            %sexto cruce
                            segundo(GE, SegundoE),
                            segundo(GI, SegundoI),
                            elegir(SegundoE, SegundoI, Ganador6),
                            %septimo cruce
                            primero(GA, PrimeroA),
                            tercero(GD, Tercero3),%%%%%
                            elegir(PrimeroA, Tercero3, Ganador7),
                            %octavo cruce
                            primero(GL, PrimeroL),
                            tercero(GF, Tercero4),
                            elegir(PrimeroL, Tercero4, Ganador8),%%%%% c,e,d,f
                            %noveno cruce
                            primero(GD, PrimeroD),
                            tercero(GB, Tercero5),
                            elegir(PrimeroD, Tercero5, Ganador9),
                            %decimo cruce
                            primero(GG, PrimeroG),
                            tercero(GA, Tercero6), %%% c,e,d,f,b,a
                            elegir(PrimeroG, Tercero6, Ganador10),
                            %undecimo cruce
                            segundo(GK, SegundoK),
                            segundo(GL, SegundoL),
                            elegir(SegundoK, SegundoL, Ganador11),
                            %duodecimo cruce
                            primero(GH, PrimeroH),
                            segundo(GJ, SegundoJ),
                            elegir(PrimeroH, SegundoJ, Ganador12),
                            %decimotercer cruce
                            primero(GJ, PrimeroJ),
                            segundo(GH, SegundoH),
                            elegir(PrimeroJ, SegundoH, Ganador13),
                            %decimocuarto cruce
                            segundo(GD, SegundoD),
                            segundo(GG, SegundoG),
                            elegir(SegundoD, SegundoG, Ganador14),
                            %decimoquinto cruce
                            primero(GB, PrimeroB),
                            tercero(GG, Tercero7),
                            elegir(PrimeroB, Tercero7, Ganador15),
                            %decimosexto cruce
                            primero(GK, PrimeroK),
                            tercero(GH, Tercero8),
                            elegir(PrimeroK, Tercero8, Ganador16),
                            Ganadores16Avos = [
                                Ganador1, Ganador2, Ganador3, Ganador4,
                                Ganador5, Ganador6, Ganador7, Ganador8,
                                Ganador9, Ganador10, Ganador11, Ganador12,
                                Ganador13, Ganador14, Ganador15, Ganador16
                            ].
    
% simula cruces de octavos
% nth0 sirve para acceder a elementos de una lista facil
octavos(Ganadores8vos) :- dieciseisavos(Ganadores16Avos),
                            nth0(0, Ganadores16Avos, Clasificado1),
                            nth0(1, Ganadores16Avos, Clasificado2),
                            nth0(2, Ganadores16Avos, Clasificado3),
                            nth0(3, Ganadores16Avos, Clasificado4),
                            nth0(4, Ganadores16Avos, Clasificado5),
                            nth0(5, Ganadores16Avos, Clasificado6),
                            nth0(6, Ganadores16Avos, Clasificado7),
                            nth0(7, Ganadores16Avos, Clasificado8),
                            nth0(8, Ganadores16Avos, Clasificado9),
                            nth0(9, Ganadores16Avos, Clasificado10),
                            nth0(10, Ganadores16Avos, Clasificado11),
                            nth0(11, Ganadores16Avos, Clasificado12),
                            nth0(12, Ganadores16Avos, Clasificado13),
                            nth0(13, Ganadores16Avos, Clasificado14),
                            nth0(14, Ganadores16Avos, Clasificado15),
                            nth0(15, Ganadores16Avos, Clasificado16),

                            elegir(Clasificado1, Clasificado2, Ganador1),
                            elegir(Clasificado3, Clasificado4, Ganador2),
                            elegir(Clasificado5, Clasificado6, Ganador3),
                            elegir(Clasificado7, Clasificado8, Ganador4),
                            elegir(Clasificado9, Clasificado10, Ganador5),
                            elegir(Clasificado11, Clasificado12, Ganador6),
                            elegir(Clasificado13, Clasificado14, Ganador7),
                            elegir(Clasificado15, Clasificado16, Ganador8),
                            
                            Ganadores8vos = [Ganador1, Ganador2, Ganador3, Ganador4, Ganador5, Ganador6, Ganador7, Ganador8].
                       
cuartos(GanadoresCuartos) :- octavos(Ganadores8vos),
                             nth0(0, Ganadores8vos, Clasificado1),
                             nth0(1, Ganadores8vos, Clasificado2), 
                             nth0(2, Ganadores8vos, Clasificado3), 
                             nth0(3, Ganadores8vos, Clasificado4),
                             nth0(4, Ganadores8vos, Clasificado5), 
                             nth0(5, Ganadores8vos, Clasificado6), 
                             nth0(6, Ganadores8vos, Clasificado7), 
                             nth0(7, Ganadores8vos, Clasificado8),

                            elegir(Clasificado1, Clasificado2, Ganador1),
                            elegir(Clasificado3, Clasificado4, Ganador2),
                            elegir(Clasificado5, Clasificado6, Ganador3),
                            elegir(Clasificado7, Clasificado8, Ganador4),

                            GanadoresCuartos = [Ganador1, Ganador2, Ganador3, Ganador4].

semis(GanadoresSemis) :- cuartos(GanadoresCuartos),
                            nth0(0, GanadoresCuartos, Clasificado1),
                            nth0(1, GanadoresCuartos, Clasificado2), 
                            nth0(2, GanadoresCuartos, Clasificado3), 
                            nth0(3, GanadoresCuartos, Clasificado4),

                            elegir(Clasificado1, Clasificado2, Ganador1),
                            elegir(Clasificado3, Clasificado4, Ganador2),

                            GanadoresSemis = [Ganador1, Ganador2].

final(Ganador) :- semis(GanadoresSemis),
                            nth0(0, GanadoresSemis, Clasificado1),
                            nth0(1, GanadoresSemis, Clasificado2),

                            elegir(Clasificado1, Clasificado2, Ganador).
