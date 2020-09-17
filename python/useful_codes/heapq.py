import heapq

numbers = [1,2,4,6,100,150,200,250]


print('The biggest numbers are: %s' %heapq.nlargest(4, numbers))
print('The smallest numbers are: %s' %heapq.nsmallest(4, numbers))

people = [
    {'firstname':'Matheus', 'age': '19'},
    {'firstname':'Leonardo', 'age': '18'},
    {'firstname':'Otavio', 'age': '28'}
]

oldest = heapq.nlargest(2, people, key=lambda s: s['age'])
print(oldest)

heapq.heappop(numbers)
print(numbers)

heapq.heappop(numbers)
print(numbers)
