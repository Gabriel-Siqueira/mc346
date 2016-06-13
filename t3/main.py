#! /usr/bin/env python
import sys



class IntervalError(Exception):
    
     def __init__(self, value):
         self.value = value
         
     def __str__(self):
         return str(self.value)

     
def to_list():

    """ Reads the intervals and crates a list with them. """

    ids = set()
    intervals = []

    for str_input in sys.stdin:

        l_input = str_input.split()
        if(len(l_input) != 3):
            raise IntervalError("Numero de valores incorreto, necessario 3 inteiros.")

        try:
            id  = int(l_input[0])
        except ValueError:
            raise IntervalError("Tipo de valor incorreto, necessario 3 inteiros.")
        try:
            beg  = int(l_input[1])
        except ValueError:
            raise IntervalError("Tipo de valor incorreto, necessario 3 inteiros.")
        try:
            end  = int(l_input[2])
        except ValueError:
            raise IntervalError("Tipo de valor incorreto, necessario 3 inteiros.")

        if id in ids:
            raise IntervalError("Id repetido.")
        elif beg > end:
            raise IntervalError("Intervalo de tamanho negativo.")
        else:
            ids |= set([id])
            
        intervals.append((beg,end))

    if len(intervals) == 0:
        raise IntervalError("Entrada vazia.")
    if len(intervals) == 1:
        raise IntervalError("Apenas um intervalo.")
    return intervals
            
def dec_intervals(intervals,units):

    """ Decrements all the 'intervals' on intervals by 'units' units. """

    for i in range( len(intervals) ):
        (beg,end) = intervals[i]
        intervals[i] = (beg,end - units)

def is_disjoint(intervals):

    """ Checks if the list 'intervals' have more then one disjoint interval. """

    acc = False
    first = True

    for (beg,end) in intervals:
        acc |= end < beg

    (_,end_max) = intervals[0]

    for i in range(1, len(intervals) ):
        (beg,end) = intervals[i];
        acc |= end_max < beg
        end_max = max(end, end_max)

    return acc 

# Main program

try:
    intervals = sorted(to_list())
except IntervalError as err:
    print "erro;",err
else:
    k = 0;
    if is_disjoint(intervals):
        while(is_disjoint(intervals)):
            dec_intervals(intervals, -1)
            k -= 1;
    else:
        while(not is_disjoint(intervals)):
            dec_intervals(intervals, 1)
            k += 1;
        k -= 1;
    print(k)
