list = ['look','atiha','this']

def long(name):
    return len(name) > 3

test = long(list[0])
print(test)
#this method is equal a filter

x = filter(long, list)
print(x)
