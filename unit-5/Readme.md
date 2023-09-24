# Network Programming

Network programming, also known as socket programming, refers to writing programs that execute across multiple devices (computers), in which the devices are all connected to each other using a network.

## **Basics**:

### **1. IP Address**:
An IP address is a unique set of numbers (such as `192.168.1.1`) that identifies a computer or a device on a network.

### **2. Ports**:
Ports can be thought of as endpoints for communication on a computer. A computer has over 65,000 ports, and a specific program can listen on a specific port for incoming connections or data.

### **3. Sockets**:
A socket provides an endpoint for sending or receiving data across a computer network. In essence, it is a combination of IP address and port, providing all the details needed to send or receive data.

## **Socket Programming**:

In many languages, network programming is achieved using sockets.

### **Server Socket**:
- Waits for requests from clients.
- Binds to a specific port on which it will listen for client requests.

### **Client Socket**:
- Used to send and receive data to/from a server.
- Needs to know the server's IP address and port number.

## **Java Example**:
Java provides a comprehensive API for network programming in the `java.net` package.

```java
// Simple Server Example
import java.net.*;
import java.io.*;

public class SimpleServer {
    public static void main(String[] args) throws IOException {
        ServerSocket serverSocket = new ServerSocket(8080); // Server will listen on port 8080
        System.out.println("Waiting for client...");
        Socket clientSocket = serverSocket.accept(); // This will wait until a client connects
        PrintWriter out = new PrintWriter(clientSocket.getOutputStream(), true);
        out.println("Hello, client!");
        serverSocket.close();
    }
}
```

```
// Simple Client Example
import java.net.*;
import java.io.*;

public class SimpleClient {
    public static void main(String[] args) throws IOException {
        Socket socket = new Socket("localhost", 8080); // Connect to server on localhost, port 8080
        BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
        String messageFromServer = in.readLine();
        System.out.println("Server says: " + messageFromServer);
        socket.close();
    }
}

```
