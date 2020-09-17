from dataclasses import dataclass

class User:
    def __init__(self, name: str, age: int, code: int):
        self.name = name
        self.age = age
        self.code = code
    def __repr__(self):
        return f'User(name={self,name}, age={self,age}, code={self,code})'

matheus = User('Matheus', 19, 10001)
#print(matheus)

@dataclass
class UserDt:
    name: str
    age: int
    code: int

matheus = UserDt('Matheus', 19, 1001)
print(matheus)
