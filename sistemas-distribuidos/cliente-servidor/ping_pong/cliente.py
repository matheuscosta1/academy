import socket

s = socket.socket()
host = socket.gethostname()
port = 13445

s.connect((host, port))

print("Conectando-se ao servidor")
data = s.recv(1024)

if data:
    print(data.decode())
    x = input()
    s.send("teste".encode())

