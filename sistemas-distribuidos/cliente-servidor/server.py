import socket

s = socket.socket()
host = socket.gethostname()
port = 13445
s.bind((host, port))

s.listen(5)
while True:
    c, addr = s.accept()
    print('Got connection from', addr)
    c.send('Thank you for connecting'.encode())
    c.send('Come back often'.encode())
    c.close() 
