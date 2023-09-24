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


# Socket Programming using TCP

Socket programming is a method of communication between two computers using a network protocol, commonly TCP/IP. TCP (Transmission Control Protocol) is a reliable, connection-oriented protocol commonly used in socket programming.

## **TCP Sockets**:
TCP ensures that all of the data arrives and is in the right order. It is typically used where data delivery is more critical than timing.

### **Server Steps**:
1. Create a Server Socket.
2. Bind to a specific port.
3. Listen for client connections.
4. Accept an incoming client connection.
5. Send and receive data.
6. Close the connection.

### **Client Steps**:
1. Create a Client Socket.
2. Connect to the server's IP address and port.
3. Send and receive data.
4. Close the connection.

## **Java TCP Socket Programming Example**:

### **Server**:

```java
import java.io.*;
import java.net.*;

public class TCPServer {
    public static void main(String[] args) throws IOException {
        ServerSocket serverSocket = new ServerSocket(8080);
        System.out.println("Server is listening on port 8080...");

        Socket clientSocket = serverSocket.accept();
        System.out.println("Connected to client...");

        DataOutputStream out = new DataOutputStream(clientSocket.getOutputStream());
        out.writeUTF("Hello from the TCP Server!");

        clientSocket.close();
        serverSocket.close();
    }
}
```


# Socket Programming using UDP

Socket programming enables communication between two machines using the User Datagram Protocol (UDP) or Transmission Control Protocol (TCP). UDP is a connectionless, unreliable protocol, meaning it does not guarantee message delivery or the order of messages. It's often faster than TCP because of the absence of error-checking and the lack of a connection setup and teardown process.

## **UDP Sockets**:
UDP sockets are typically used in situations where low latency is more crucial than reliability, such as streaming audio or video.

### **Server Steps**:
1. Create a Datagram Socket.
2. Bind to a specific port.
3. Receive a Datagram Packet.
4. Send a Datagram Packet (if necessary).
5. Close the Datagram Socket.

### **Client Steps**:
1. Create a Datagram Socket.
2. Send a Datagram Packet to the server.
3. Receive a Datagram Packet from the server (if expected).
4. Close the Datagram Socket.

## **Java UDP Socket Programming Example**:

### **Server**:

```java
import java.io.*;
import java.net.*;

public class UDPServer {
    public static void main(String[] args) throws IOException {
        DatagramSocket socket = new DatagramSocket(8080);
        System.out.println("Server is listening on port 8080...");

        byte[] buffer = new byte[1024];
        DatagramPacket packet = new DatagramPacket(buffer, buffer.length);
        socket.receive(packet);

        String message = new String(packet.getData(), 0, packet.getLength());
        System.out.println("Received from client: " + message);

        socket.close();
    }
}
```


```

import java.io.*;
import java.net.*;

public class UDPClient {
    public static void main(String[] args) throws IOException {
        DatagramSocket socket = new DatagramSocket();

        byte[] buffer = "Hello from the UDP Client!".getBytes();
        InetAddress address = InetAddress.getByName("localhost");
        DatagramPacket packet = new DatagramPacket(buffer, buffer.length, address, 8080);

        socket.send(packet);
        System.out.println("Message sent to the server...");

        socket.close();
    }
}


```

# Java URL Handling Example

This example demonstrates various aspects of handling URLs in Java.

```java

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.net.URI;

public class URLHandlingExample {

    public static void main(String[] args) throws Exception {

        // **1. Creating a URL**
        URL myURL = new URL("https://www.google.com/search?q=testing+url&newwindow=1&sca_esv=567971749&sxsrf=AM9HkKmpZKyEP98GXeS1S18YgC_JMI9E2A%3A1695548636186&source=hp&ei=3AQQZcX0CNeghwPfhYvIAQ&iflsig=AO6bgOgAAAAAZRAS7KxLkN7iYsQ483BUGdC0axKdKnSm&ved=0ahUKEwjF0qDx-sKBAxVX0GEKHd_CAhkQ4dUDCAk&uact=5&oq=testing+url&gs_lp=Egdnd3Mtd2l6Igt0ZXN0aW5nIHVybDIIEAAYywEYgAQyCBAAGMsBGIAEMgYQABgWGB4yBhAAGBYYHjIGEAAYFhgeMgYQABgWGB4yBhAAGBYYHjIGEAAYFhgeMgYQABgWGB4yBhAAGBYYHkjGLlC_AVjhK3AHeACQAQCYAbABoAHBEKoBBDAuMTW4AQPIAQD4AQGoAgrCAgcQIxjqAhgnwgIEECMYJ8ICBxAjGIoFGCfCAgcQABgTGIAEwgIKEAAYywEYgAQYCsICCRAAGB4Y8QQYCsICBBAAGB4&sclient=gws-wiz");
        System.out.println("Created URL: " + myURL);

        // **2. Accessing URL Components**
        System.out.println("\nURL Components:");
        System.out.println("Protocol: " + myURL.getProtocol());
        System.out.println("Host: " + myURL.getHost());
        System.out.println("Port: " + myURL.getPort());
        System.out.println("Path: " + myURL.getPath());
        System.out.println("Query: " + myURL.getQuery());
        System.out.println("Ref: " + myURL.getRef());

        // **3. Reading Content from a URL** (For demonstration, this will be commented to prevent actual fetch)
        /*
        System.out.println("\nReading URL Content:");
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(myURL.openStream()))) {
            String line;
            while ((line = reader.readLine()) != null) {
                System.out.println(line);
            }
        }
        */

        // **4. URLConnection Class**
        URLConnection conn = myURL.openConnection();
        System.out.println("\nContent-Type from URLConnection: " + conn.getContentType());

        // **5. Working with URL Query Parameters**
        System.out.println("\nURL Query Parameters:");
        URI uri = myURL.toURI();
        String query = uri.getQuery();
        for (String param : query.split("&")) {
            String[] keyValue = param.split("=");
            System.out.println("Key: " + keyValue[0] + ", Value: " + keyValue[1]);
        }
    }
}

```



# Java Mail API Tutorial

Java Mail API provides the capability to send and receive emails. In this tutorial, we'll go through the steps of setting up the environment, sending a simple email, and reading emails from an inbox.

## Prerequisite:

- You need to add `javax.mail.jar` to your project. This can be downloaded from the Maven repository or the official website.

## Sending Email:

To send an email, you need to set up a `Session`, then use the `Message` class to set up and send the message.

```java
final String username = "youremail";
		final String password = "password";

		Properties prop = new Properties();
		prop.put("mail.smtp.host", "smtp.gmail.com");
		prop.put("mail.smtp.port", "587");
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.starttls.enable", "true"); // TLS

		Authenticator auth = new Authenticator() {
			// override the getPasswordAuthentication method
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		};

		Session session = Session.getInstance(prop, auth);
		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("youremail.com"));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse("youremail.com"));
			message.setSubject("Testing Gmail TLS");
			message.setText("Hello, this is a test email!");

			Transport.send(message);

			System.out.println("Sent successfully!");

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
```
