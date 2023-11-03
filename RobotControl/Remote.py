import socket

# Define the server's host and port
host = "127.0.0.1"  # Change this to the server's IP address or hostname
port = 8000       # Change this to the server's port

# Create a socket object
client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Connect to the server
client_socket.connect((host, port))

while True:
    message = input("Enter a message (or 'exit' to quit): ")
    
    if message.lower() == "exit":
        break

    # Send the message to the server
    client_socket.send(message.encode())

    # Receive the server's response
    data = client_socket.recv(1024)

    print(f"Server response: {data.decode()}")

# Close the client socket
client_socket.close()
