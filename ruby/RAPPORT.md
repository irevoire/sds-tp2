### Romain Grossemy
### Thomas Campistron

# Part 1

## Changer les capabilities

Comme tout bon rubyiste qui n'a pas le temps, notre première approche à été de trouver une gemme (librairie) qui permette de dropper des capabilities.
Nous avons trouvé : [cap2](https://github.com/lmars/cap2)

### Problème

* La gemme permet de dropper les "effectives capabilities" mais pas les "permitted capabilites"
------------
Nous avons corrigé la lib.

* On ne peut pas non plus agir sur d'autres process, lorsqu'un donne un PID différent du notre la lib le refuse.

