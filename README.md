# FIFA World Cup Simulator in Prolog

> A logic programming project that models a 48-team FIFA World Cup tournament using Prolog's built-in non-determinism and randomization capabilities.

---

## Table of Contents

1. [Overview](#overview)
2. [Motivation and Academic Context](#motivation-and-academic-context)
3. [Tournament Structure](#tournament-structure)
4. [System Requirements](#system-requirements)
5. [How to Run](#how-to-run)
6. [Project Structure](#project-structure)
7. [Core Predicates](#core-predicates)
8. [Design Decisions](#design-decisions)
9. [Limitations and Future Work](#limitations-and-future-work)
10. [Author](#author)

---

## Overview

This project implements a stochastic simulation of a FIFA World Cup tournament using **SWI-Prolog**. It models the full bracket from the group stage through to the final, covering 48 national teams distributed across 12 groups (A through L). Match outcomes are determined randomly, reflecting the inherent unpredictability of competitive football, and the simulation can be re-run indefinitely to produce different results.

---

## Motivation and Academic Context

This project was developed in the context of a **Logic Programming** course. Its primary goal is to demonstrate how declarative, rule-based reasoning can model a real-world combinatorial process — a football tournament — in a natural and concise way.

Key concepts illustrated:

- **Facts and rules** as the foundation of a knowledge base (team membership per group).
- **Backtracking** and Prolog's execution model, explored implicitly through the use of `findall/3` and `random_member/2`.
- **Higher-order predicates** via `call/2` to abstract over group identifiers.
- **List processing** using pattern matching (`[H|T]`) and index-based access (`nth0/3`).
- **Non-determinism as a modeling tool**: randomness is used to simulate the unpredictability of match outcomes without encoding explicit probabilities or rankings.

The tournament model serves as a practical exercise in expressing structured, rule-governed processes entirely through logical relations.

---

## Tournament Structure

The simulation follows a simplified version of the expanded 48-team World Cup format:

| Phase             | Teams In | Teams Out | Method                        |
|-------------------|----------|-----------|-------------------------------|
| Group Stage       | 48       | 32        | Random permutation per group  |
| Round of 32 (16avos) | 32    | 16        | Cross-bracket matchups        |
| Round of 16 (octavos) | 16   | 8         | Head-to-head eliminations     |
| Quarter-finals    | 8        | 4         | Head-to-head eliminations     |
| Semi-finals       | 4        | 2         | Head-to-head eliminations     |
| Final             | 2        | 1         | Single match, winner declared |

**Groups (A–L), 4 teams each:**

| Group | Teams                                          |
|-------|------------------------------------------------|
| A     | Mexico, South Africa, South Korea, Czechia     |
| B     | Canada, Bosnia, Qatar, Switzerland             |
| C     | Brazil, Morocco, Haiti, Scotland               |
| D     | USA, Paraguay, Australia, Turkey               |
| E     | Germany, Curaçao, Côte d'Ivoire, Ecuador       |
| F     | Netherlands, Japan, Sweden, Tunisia            |
| G     | Belgium, Egypt, Iran, New Zealand              |
| H     | Spain, Cape Verde, Saudi Arabia, Uruguay       |
| I     | France, Senegal, Iraq, Norway                  |
| J     | Argentina, Algeria, Austria, Jordan            |
| K     | Portugal, Congo, Uzbekistan, Colombia          |
| L     | England, Croatia, Ghana, Panama                |

---

## System Requirements

- [SWI-Prolog](https://www.swi-prolog.org/) version 8.x or later
- The `random` library (bundled with SWI-Prolog by default)

---

## How to Run

### 1. Load the program

```prolog
?- [fixture].
```

### 2. Query any stage of the tournament

Simulate the entire tournament and get the champion:

```prolog
?- final(Ganador).
Ganador = argentina.
```

Simulate up to the semi-finals:

```prolog
?- semis(Finalistas).
Finalistas = [brasil, españa].
```

Simulate up to the quarter-finals:

```prolog
?- cuartos(Equipos).
```

Simulate up to the round of 16:

```prolog
?- octavos(Equipos).
```

Simulate the full group stage and round of 32:

```prolog
?- dieciseisavos(Clasificados).
```

> Each query produces a different result due to random permutations and random matchup resolution. Re-run any query to get a new simulation.

---

## Project Structure

```
mundial.pl
│
├── Facts
│   └── grupoA/1 ... grupoL/1       — Team membership per group
│
├── Utility Predicates
│   ├── lista_de/2                  — Collects all members of a group into a list
│   ├── primero/2, segundo/2,
│       tercero/2, cuarto/2         — Positional accessors for 4-element lists
│   ├── elegir/3                    — Randomly selects one of two teams (match simulation)
│   └── sim/2                       — Randomly permutes a group (simulates group stage)
│
└── Simulation Predicates
    ├── simular_grupos/12            — Runs all 12 group stages simultaneously
    ├── dieciseisavos/1              — Simulates the Round of 32
    ├── octavos/1                    — Simulates the Round of 16
    ├── cuartos/1                    — Simulates the Quarter-finals
    ├── semis/1                      — Simulates the Semi-finals
    └── final/1                      — Simulates the Final and returns the champion
```

---

## Core Predicates

### `lista_de/2`

```prolog
lista_de(Predicado, Lista) :- findall(X, call(Predicado, X), Lista).
```

A generic higher-order predicate that collects all solutions for a given group predicate. Enables `sim/2` to work uniformly across all 12 groups without duplication.

### `elegir/3`

```prolog
elegir(A, B, X) :- random_member(X, [A, B]).
```

Models a single match between two teams. The winner is selected with equal probability, reflecting that no ranking data is encoded in the model.

### `sim/2`

```prolog
sim(Grupo, GrupoDefinido) :- lista_de(Grupo, ListaGrupo), random_permutation(ListaGrupo, GrupoDefinido).
```

Simulates a group stage by randomly permuting the list of teams. The resulting order determines classification positions (1st, 2nd, 3rd, 4th).

### `dieciseisavos/1`

The most structurally complex predicate. It calls `simular_grupos/12` to obtain classified positions, then applies 16 specific cross-bracket matchups based on finishing positions (e.g., 2nd of Group A vs. 2nd of Group B). Winners are collected in an ordered list for the next round.

---

## Design Decisions

**Uniform random outcomes.** No team is assigned a rating or weight. This is a deliberate simplification: the model focuses on *structure* (bracket logic, group dynamics) rather than *prediction*. The goal is to demonstrate logical reasoning, not statistical accuracy.

**Position-based classification.** The random permutation of a group list implicitly assigns finishing positions. `primero/2`, `segundo/2`, etc., extract these positions via pattern matching, keeping the code declarative and readable.

**Chained predicate calls.** Each round calls the previous one (`final` → `semis` → `cuartos` → `octavos` → `dieciseisavos` → `simular_grupos`). This chain makes the dependency structure explicit and matches the natural causal flow of a real tournament.

**`nth0/3` for list access in knockout rounds.** From the Round of 16 onward, `nth0/3` is used instead of named accessors, since the intermediate lists are not of fixed arity and benefit from index-based access.

---

## Limitations and Future Work

- **No weighted probabilities.** All matchups are 50/50. Future versions could incorporate FIFA rankings or Elo ratings to weight `elegir/3`.
- **No third-place match.** The simulation ends at the final; a third-place playoff could be added by extending `semis/1` to also track losing finalists.
- **Group stage logic is simplified.** `random_permutation/2` approximates group classification without modeling individual match scores, points, or goal differences.
- **No bracket visualization.** Output is purely textual via the Prolog interpreter. A DCG-based or HTML output layer could improve readability.
- **Monte Carlo analysis.** Running `final/1` thousands of times and aggregating results would yield approximate win probabilities per team — a natural extension using `aggregate_all/3` or `assert/retract` counters.

---

## Author

Developed as an academic exercise in **Logic Programming** using SWI-Prolog.
