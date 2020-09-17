import json

dict = '{"name":"John", "age":"36", "city":"NY"}'

y = json.loads(dict)

print(y["name"])
