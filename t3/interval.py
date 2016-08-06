import sys
class InputError(Exception):

     """ Input with wrong format. """
     
     def __init__(self, value):
         self.value = value
         
     def __str__(self):
         return str(self.value)

class Interval:

     """ Representation of a interval. """
     
     def __init__(self, id, beg, end):

        # Verifica se os estremos estao na ordem correta.
        if beg > end:
            raise InputError("Intervalo de tamanho negativo.")
        self.id = id
        self.end = end
        self.beg = beg

class Intervals:
     
    def __init__(self):

        """ Reads the intervals and crates a list with them. """

        ids = set()
        self.intervals = []

        for str_input in sys.stdin:
            l_input = str_input.split()

            # Verifica numero de valores para representar um intervalo.
            if(len(l_input) != 3):
                  raise InputError("Numero de valores incorreto, necessario 3 inteiros.")

            # Verifica os tipos dos valores.
            try:
                  id  = int(l_input[0])
                  beg  = int(l_input[1])
                  end  = int(l_input[2])
            except ValueError:
                  raise InputError("Tipo de valor incorreto, necessario 3 inteiros.")

            # Checa a existencia de id repetido.
            if id in ids:
                  raise InputError("Id repetido.")
            else:
                  ids |= set([id])

            # Adiciona a lista de intervalos.
            self.intervals.append(Interval(id,beg,end))

        # Verifica se a entrada possui mais de 2 intervalos.
        if len(self.intervals) == 0:
              raise InputError("Entrada vazia.")
        if len(self.intervals) == 1:
              raise InputError("Apenas um intervalo.")

    def sort(self):

        """ Sorts the list of intervals. """
        
        self.intervals = sorted(self.intervals, key=lambda interval: interval.beg)
   
    def dec(self, units):

        """ Decrements all the 'intervals' on intervals by 'units' units. """

        for i in self.intervals:
            i.end -= units

    def is_disjoint(self):

        """ Checks if the list 'intervals' have more then one disjoint interval. """

        acc = False
        first = True

        # Verifica se o intervalo nao tem tamanho zero ou negativo.
        for it in self.intervals:
            acc |= it.end < it.beg

        # Verifica se os intervalos possuem intersecoes.
        end_max = self.intervals[0].end
        for i in range(1, len(self.intervals) ):
            acc |= end_max < self.intervals[i].beg
            end_max = max(self.intervals[i].end, end_max)

        return acc 
