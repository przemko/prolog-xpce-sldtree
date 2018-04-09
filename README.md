# prolog-xpce-sldtree
Wizualizacja SLD-drzewa.

## Uruchamianie

Należy zaimportować moduł **sldtree**. Eksportuje on jednoargumentowy predykat __sld_tree/1__, którego argumentem jest zadany cel. Cel powinien korzystać tylko z predykatów zdefiniowanych w postaci klauzul (wywołanie predykatów zdefiniowanych w C, takich jak np. __=/2__, __!/0__ czy __is/2__ zakończy się błędem wykonania).

```prolog
?- use_module(sldtree).
?- use_module(library(lists)).
?- sld_tree(append(X, Y, [1, 2, 3, 4])).
% SLD-drzewo zapisano w pliku: sldtree1.eps
```

## Przykłady

### append(X, X, [1, 2, 3, 1, 2, 3])

![przykład 1](sldtree1.png "Przykład 1")

### append(X, Y, [1, 2, 3, 1, 2, 3]), X = Y

![przykład 2](sldtree2.png "Przykład 2")

