cycle_number = 3
population = 1000
shablon  = 'C:/Algorithms/My papers/Battery placing/find-57-inf/shablon.rg2'
filename = 'C:/Algorithms/My papers/Battery placing/find-57-inf/ieee_57norm.rg2'
gen_variables = {
'power_battery': (1, 3, 5, 8, 10, 15, 20),
'price_battery': (15, 30, 45, 70, 80, 105, 120),
# 'power_battery': (20),
# 'price_battery': (1),
}
limits = {
'maximum_sum': 120,
'maximum_number': 8,
'nodes': [i+17 for i in range(40)],
}
mutation_percentage = 80
type_of_task = ['find_better', 'find_number']
