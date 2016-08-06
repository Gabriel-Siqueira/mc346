#! /usr/bin/env python
from interval import InputError, Intervals

# Main program

try:
     # cria a representacao dos intervalos
     intervals = Intervals()
     intervals.sort()
except InputError as err:
    print "erro;",err
else:
    k = 0;
    # se forem disjuntos
    if intervals.is_disjoint():
        # incrementa ate deicharem de ser disjuntos 
        while(intervals.is_disjoint()):
            intervals.dec(-1)
            k -= 1;
    # se nao forem disjuntos
    else:
        # decrementa ate se tornarem disjuntos
        while(not intervals.is_disjoint()):
            intervals.dec(1)
            k += 1;
        k -= 1;
    print(k)
