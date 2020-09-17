a,b,c = (1,2,3)
print(a)

first, *more, last = (1,2,3,4,5)
print(*more)

list = [1,2,3]
convert = tuple(list)
print('--------')
print(convert)
concat =(a,b,c) +  convert
print(concat)

print(concat[::-1])
print(concat[-1::])
print(concat[1::1])
print(concat[::])
