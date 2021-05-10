import win32com.client
import math


class RastrTable(object):
    def __init__(self, filename, shablon):
        self.rastr = win32com.client.Dispatch('Astra.Rastr')
        self.rastr.Load(1, filename, shablon)

    def get_size(self, table):
        return self.rastr.Tables(table).Size

    def set(self, table, column, node, value):
        cur_val = self.get(table, column, node)
        self.rastr.Tables(table).Cols(column).SetZ(node, value)
        if column == 'qmax':
            self.rastr.Tables(table).Cols(column).SetZ(node, cur_val+value)
            self.rastr.Tables(table).Cols('qmin').SetZ(node, cur_val-value)
            cur_val = self.get(table, 'uhom', node)
            self.rastr.Tables(table).Cols('vzd').SetZ(node, cur_val)

    def get(self, table, column, node):
        return self.rastr.Tables(table).Cols(column).Z(node)

    def set_all(self, table, column, node, value):
        for i in range(len(column)):
            self.set(table[i], column[i], node[i], value[i])

    def get_all_sum(self, table, column):
        sum = 0
        for i in range(self.get_size(table)):
            sum += math.fabs(self.get(table, column, i))

        return sum

    def get_all_sum_except(self, table, column, list):
        sum = 0
        for i in range(self.get_size(table)):
            if i not in list:
                sum += math.fabs(self.get(table, column, i))

        return sum

    def get_max_of_all(self, table, column):
        biggest_one = math.fabs(self.get(table, column, 0))

        for i in range(1, self.get_size(table)):
            value = math.fabs(self.get(table, column, i))
            biggest_one = max(biggest_one, value)

        return biggest_one

    def get_max_of_all_except(self, table, column, list):
        check = 0
        while check in list:
            check += 1

        biggest_one = math.fabs(self.get(table, column, check))

        for i in range(check, self.get_size(table)):
            if i not in list:
                value = math.fabs(self.get(table, column, i))
                biggest_one = max(biggest_one, value)

        return biggest_one
