#with open('teste', 'r') as fileobj:
#    lines = fileobj.readlines()
#print(lines)


with open('teste', 'r') as fileobj:
    content = fileobj.read()
    lines = content.split('\n')
print(lines)


