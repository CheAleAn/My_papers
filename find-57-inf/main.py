import matplotlib.pyplot as plt
import time

import params as p
from rastr import RastrTable
from genetic_algorithm import Person, Population, FitScores

start = time.process_time()
if __name__ == '__main__':
    rastr = RastrTable(p.filename, p.shablon)
    cycle = 1
    print(cycle)
    pop = Population(p.gen_variables, rastr, p.limits)
    # pop.create_origin()
    pop.create(p.population)
    pop.fitness('node', 'qmax', p.filename, p.shablon)
    print(pop.generation)
    pop.sort()
    pop.take_best(p.population)
    while cycle < p.cycle_number:
        cycle += 1
        print(cycle)
        new_pop = Population()
        new_pop.crossing(pop)
        new_pop.mutation(p.mutation_percentage)
        new_pop.fitness('node', 'qmax', p.filename, p.shablon)
        pop.add(new_pop)
        pop.sort()
        pop.take_best(p.population)

    pop.show_best(10)
    end = time.process_time()
    print(start, end)

    fig = plt.figure()
    for i in range(pop.population_size):
        plt.scatter(pop.generation[i].fit[0], pop.generation[i].fit[1], c='black')
    plt.scatter(28.098644288631643, 4.5664550747814285, c='deeppink')
    plt.show()
    print('57')
