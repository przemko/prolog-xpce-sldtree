# prolog-xpce-sldtree
Wizualizacja SLD-drzewa.

## Uruchamianie

Należy zaimportować moduł **sldtree**. Eksportuje on jednoargumentowy predykat __sldtree/1__, którego argumentem jest zadany cel. Cel powinien korzystać tylko z predykatów zdefiniowanych w postaci klauzul (wywołanie predykatów zdefiniowanych w C, takich jak np. __=/2__, __!/0__ czy __is/2__ zakończy się błędem wykonania).

```prolog
?- use_module(sldtree).
?- use_module(library(lists)).
?- sldtree(append(
```

## Przykłady

![przykład 1](sldtree1.png "Przykład 1")

![przykład 2](sldtree2.png "Przykład 2")

