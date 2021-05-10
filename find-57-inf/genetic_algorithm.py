import random as r

from rastr import RastrTable

class FitScores(object):
    def __init__(self):
        self.scores = []
        self.rang = []
        self.place = []

    def __rept__(self):
        return f'{self.scores} {self.place} {self.rang}'

    def add_to_sort(self, pop, new_pop=None):
        for i in range(pop.population_size):
            self.scores.append(pop.generation[i].fit)
            self.place.append(i)
            self.rang.append(0)

        self.length = pop.population_size

    def to_clean(self):
        self.scores = []
        self.rang = []
        self.place = []

    def sorting(self):
        pareto_rang = 0
        sfc = FitScores()
        for i in range(self.length):
            sfc.scores.append(self.scores[i])
            sfc.place.append(self.place[i])

        while bool(len(sfc.place)):
            pareto_rang += 1
            sfc.rang = [pareto_rang for i in range(len(sfc.place))]
            for i in range(len(sfc.place) - 1):
                for j in range(i + 1, len(sfc.place)):
                    if (sfc.scores[i][1] == sfc.scores[j][1]) & (sfc.scores[i][0] == sfc.scores[j][0]):
                        sfc.rang[j] = 0
                    elif (sfc.scores[i][1] >= sfc.scores[j][1]) & (sfc.scores[i][0] >= sfc.scores[j][0]):
                        sfc.rang[i] = 0
                    elif (sfc.scores[i][1] <= sfc.scores[j][1]) & (sfc.scores[i][0] <= sfc.scores[j][0]):
                        sfc.rang[j] = 0

            for i in range(len(sfc.place)):
                if sfc.rang[i]:
                    self.rang[sfc.place[i]] = sfc.rang[i]

            sfc.to_clean()
            for i in range(self.length):
                if self.rang[i] == 0:
                    sfc.scores.append(self.scores[i])
                    sfc.place.append(self.place[i])

        self.biggest_rang = pareto_rang

    def sorting_3(self):
        pareto_rang = 0
        sfc = FitScores()
        for i in range(self.length):
            sfc.scores.append(self.scores[i])
            sfc.place.append(self.place[i])

        while bool(len(sfc.place)):
            pareto_rang += 1
            sfc.rang = [pareto_rang for i in range(len(sfc.place))]
            for i in range(len(sfc.place) - 1):
                for j in range(i + 1, len(sfc.place)):
                    if (sfc.scores[i][1] == sfc.scores[j][1]) & (sfc.scores[i][0] == sfc.scores[j][0]) & (sfc.scores[i][2] == sfc.scores[j][2]):
                        sfc.rang[j] = 0
                    elif (sfc.scores[i][1] >= sfc.scores[j][1]) & (sfc.scores[i][0] >= sfc.scores[j][0]) & (sfc.scores[i][2] >= sfc.scores[j][2]):
                        sfc.rang[i] = 0
                    elif (sfc.scores[i][1] <= sfc.scores[j][1]) & (sfc.scores[i][0] <= sfc.scores[j][0]) & (sfc.scores[i][2] <= sfc.scores[j][2]):
                        sfc.rang[j] = 0

            for i in range(len(sfc.place)):
                if sfc.rang[i]:
                    self.rang[sfc.place[i]] = sfc.rang[i]

            sfc.to_clean()
            for i in range(self.length):
                if self.rang[i] == 0:
                    sfc.scores.append(self.scores[i])
                    sfc.place.append(self.place[i])

        self.biggest_rang = pareto_rang


class Person(object):
    def __init__(self):
        self.fit = None
        self.params = []
        self.rang = 0

    def __repr__(self):
        battery = []
        place = []
        sum = self.count_sum()
        fit = []
        for i in range(len(self.params)):
            battery.append(self.params[i][1])
            place.append(self.params[i][0]+1)

        for i in range(len(self.fit)):
            fit.append(round(self.fit[i],5))

        return f'battery:{battery} place:{place} sum:{sum} {fit} {self.rang}'

    def count_sum(self):
        sum = 0
        for index in range(len(self.params)):
            sum += self.count_cost(index)
        return sum

    def count_cost(self, one):
        key = self.params[one][1]
        i = self.gen_variables['power_battery'].index(key)
        return self.gen_variables['price_battery'][i]

    def crossing_by_one_point(self, other):
        if len(self.params) > 2:
            key = r.randint(1, len(self.params)-1)
        else:
            key = 1
        for t in range(key, len(other.params)):
            if t <= (len(self.params)-1):
                self.params[t] = other.params[t]
            else:
                self.params.append(other.params[t])

        cost = self.count_sum()
        while cost > self.limits['maximum_sum']:
            index = r.randint(0, len(self.params)-1)
            self.replace_battery(index, False)
            cost = self.count_sum()

    def mutation(self):
        chance = r.random()
        if chance <= 0.33:
            i = r.randint(0, len(self.params) - 1)
            self.replace_node(i)
        elif chance <= 0.67:
            i = r.randint(0, len(self.params) - 1)
            self.replace_battery(i)
        else:
            if len(self.params) < self.limits['maximum_number']:
                potential = self.limits['maximum_sum'] - self.count_sum()
                if potential >= min(self.gen_variables['price_battery']):
                    nodes = []
                    for t in range(len(self.params)):
                        nodes.append(self.params[t][0])
                    gen, _ = self.create_gen(potential, nodes)
                    self.params.append(gen)

    def replace_battery(self, index, more=True):
        cost = self.count_sum()
        lost_cost = self.count_cost(index)
        cost -= lost_cost
        nodes = []
        for t in range(len(self.params)):
            nodes.append(self.params[t][0])
        current_reserv = self.limits['maximum_sum']-cost
        if more:
            self.params[index], new_cost = self.create_gen(current_reserv, nodes, self.params[index][0])
        else:
            self.params[index], new_cost = self.create_gen(lost_cost, nodes, self.params[index][0])
        cost += new_cost

    def replace_node(self, index):
        nodes = []
        for t in range(len(self.params)):
            nodes.append(self.params[t][0])

        a = r.randint(0, len(self.limits['nodes'])-1)
        if a not in nodes:
            self.params[index] = (a, self.params[index][1])

    def fitness(self, rastr, table, key):
        for i in range(len(self.params)):
            rastr.set(table,key,self.params[i][0],self.params[i][1])

        rastr.rastr.Rgm('')
        sum = self.count_sum()
        self.fit = [rastr.get_all_sum('vetv', 'dp'),
                    rastr.get_max_of_all_except('node', 'otv', [0, 1, 2, 5, 7, 8, 11]),
                    sum]

    def create_gen(self, sum, nodes, def_node=None):
        while 1:
            if def_node is None:
                a = r.randint(0, len(self.limits['nodes'])-1)
                current_node = self.limits['nodes'][a]
            else:
                current_node = def_node
            if (current_node not in nodes) or (def_node is not None):
                j = r.randint(0, len(self.gen_variables['power_battery'])-1)
                if self.gen_variables['price_battery'][j] <= sum:
                    gen = (
                        current_node,
                        self.gen_variables['power_battery'][j],
                    )
                    return gen, self.gen_variables['price_battery'][j]

    def create(self, gen_variables, limits):
        nodes = []
        self.limits = limits
        battery_number = r.randint(2, self.limits['maximum_number'])
        sum = self.limits['maximum_sum']
        self.gen_variables = gen_variables
        while battery_number and sum>=min(gen_variables['price_battery']):
            gen, cost = self.create_gen(sum, nodes)
            self.params.append(gen)
            nodes.append(gen[0])
            sum -= cost
            battery_number -= 1

    def create_origin(self, gen_variables, limits, node):
        self.limits = limits
        sum = self.limits['maximum_sum']
        self.gen_variables = gen_variables
        gen = (
            node,
            max(self.gen_variables['power_battery'])
        )
        self.params.append(gen)

class Population(object):
    def __init__(self, gen_variables=None, rastr=None, limits=None):
        self.generation = []
        self.programm = rastr
        self.limits = limits
        self.gen_variables = gen_variables

    def create_origin(self):
        self.population_size = len(self.limits['nodes'])
        for i in range(self.population_size):
            ind = Person()
            ind.create_origin(self.gen_variables, self.limits, self.limits['nodes'][i])
            self.generation.append(ind)

    def create(self, population_size):
        self.population_size = population_size
        for i in range(self.population_size):
            ind = Person()
            ind.create(self.gen_variables, self.limits)
            self.generation.append(ind)

    def crossing(self, other):
        self.population_size = other.population_size
        self.gen_variables = other.gen_variables
        self.limits = other.limits
        self.programm = other.programm
        for i in range(self.population_size):
            created = False
            while not created:
                j = r.randint(0, other.population_size - 1)
                k = r.randint(0, other.population_size - 1)
                if j != k:
                    ind = Person()
                    ind.gen_variables = self.gen_variables
                    ind.limits = self.limits
                    if len(other.generation[j].params) < len(other.generation[k].params):
                        for l in other.generation[j].params:
                            ind.params.append(l)
                        ind.crossing_by_one_point(other.generation[k])
                    else:
                        for l in other.generation[k].params:
                            ind.params.append(l)
                        ind.crossing_by_one_point(other.generation[j])
                    ind.fit = None
                    ind.rang = 0
                    self.generation.append(ind)
                    created = True

    def mutation(self, mut_percentage):
        for i in range(self.population_size):
            if r.random() <= (mut_percentage/100):
                self.generation[i].mutation()

    def bubble_sort(self):
        moves = 0
        while not moves:
            moves = 1
            for i in range(len(self.generation)-1):
                if self.generation[i].rang > self.generation[i+1].rang:
                    self.generation[i], self.generation[i+1] = self.generation[i+1], self.generation[i]
                    moves = 0

    def to_clean(self):
        self.generation = []

    def fitness(self, table, key, filename, shablon):
        for i in range(self.population_size):
            rastr = RastrTable(filename, shablon)
            self.generation[i].fitness(rastr, table, key)

    def take_best(self, taken_size):
        sort_pop = Population()
        for i in range(self.population_size):
            sort_pop.generation.append(self.generation[i])

        sort_pop.bubble_sort()

        self.to_clean()
        for i in range(taken_size):
            self.generation.append(sort_pop.generation[i])

        self.population_size = taken_size

    def show_best(self, num):
        best_pop = Population()
        for i in range(self.population_size):
            if 0 < self.generation[i].rang <= num:
                best_pop.generation.append(self.generation[i])

        for i in best_pop.generation:
            print(i)

    def return_best(self, num):
        best_pop = Population()
        best_pop.population_size = 0
        for i in range(self.population_size):
            if 0 < self.generation[i].rang <= num:
                best_pop.generation.append(self.generation[i])
                best_pop.population_size += 1

        return best_pop

    def add(self, another_pop):
        for i in range(self.population_size):
            self.generation[i].rang = 0

        self.population_size = self.population_size + another_pop.population_size
        for i in range(another_pop.population_size):
            self.generation.append(another_pop.generation[i])

    def sort(self):
        pop_for_sort = FitScores()
        pop_for_sort.add_to_sort(self)
        pop_for_sort.sorting()

        for i in range(len(self.generation)):
            self.generation[i].rang = pop_for_sort.rang[i]
