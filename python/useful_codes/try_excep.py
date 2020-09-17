x = "x"
try:
     print(int(x))
except NameError:
    print('Variable x isnt defined')
except:
    print('Something else went wrong')

