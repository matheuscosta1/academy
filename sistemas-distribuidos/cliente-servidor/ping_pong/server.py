import socket

s = socket.socket()
host = socket.gethostname()
port = 13445
s.bind((host, port))

print('Waiting for connection.')

s.listen(5)
while True:

    c, addr = s.accept()
    print('Conectado ao', addr)
    c.send('Conectado'.encode())
    print('Waiting for message')
    c.send('Digite uma mensagem'.encode())
    s.accept()
    data = s.recv(1024)
    print(data.decode())
    c.close()
