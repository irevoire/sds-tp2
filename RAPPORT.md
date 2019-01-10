### Romain Grossemy
### Thomas Campistron

## Changer les capabilities

Comme tout bon rubyiste qui n'a pas le temps, notre première approche à été de trouver une gemme (librairie) qui permette de dropper des capabilities.
Nous avons trouvé : [cap2](https://github.com/lmars/cap2)

### Problème

* La gemme permet de dropper les "effectives capabilities" mais pas les "permitted capabilites"
------------
Nous avons corrigé la lib.

* On ne peut pas non plus agir sur d'autres process, lorsqu'un donne un PID différent du notre la lib le refuse.
------------
Nous avons corrigé la lib pour permettre d'agir sur d'autres processus.
Il fallait utiliser la fonction capsetp(pid, struct) plutôt que la fonction puis la call en C indique "Operation not permitted".
Après avoir lu la manpage il semblerait qu'il n'est plus possible de changer les capabilities d'autres processus :
```
Where  supported  by  the kernel, the function capsetp() should be used with care.  It existed, primarily, to overcome an early lack of support for capabilities in the filesystems
supported by Linux.  Note that, by default, the only processes that have CAP_SETPCAP available to them are processes started as a kernel thread.  (Typically this includes init(8),
kflushd and kswapd). You will need to recompile the kernel to modify this default.
```

## Créer des cgroups

Nous utilisons la librairie `libcgroup`, puis a l'aide d'appel en bash on peut limiter l'utilisation du cpu ou de la mémoire.

### Problème

Pour l'instant on ne peut que limiter la priorité d'un processus pour l'utilisation du CPU.
