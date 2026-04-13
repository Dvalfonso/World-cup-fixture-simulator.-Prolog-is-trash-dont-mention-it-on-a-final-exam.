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

% predicado generico que recibe un predicado por ejemplo grupoA y te devuelve la lista de X para los cuales grupoA(X) es true
lista_de(Predicado, Lista) :- findall(X, call(Predicado, X), Lista).
