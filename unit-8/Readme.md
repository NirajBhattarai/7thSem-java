# Java RMI (Remote Method Invocation)

Java RMI is a mechanism that allows one Java Virtual Machine (JVM) to invoke methods on an object running in another JVM. It is used to build distributed applications; through RMI, programs can execute remote functions, where the object is serialized and sent across the network to another JVM, executed there, and the result is serialized and sent back.

## Introduction

Java RMI simplifies the development of distributed Java applications, providing a natural Java-based approach to invoking methods remotely. It uses Java's object serialization mechanism to marshal and unmarshal parameters and does not truncate types, meaning that rich object-oriented data structures can be used.

![RMI Architecture](https://media.geeksforgeeks.org/wp-content/uploads/20211028122357/workingofRMI.jpg)

RMI uses two key pieces:

- **Stubs and Skeletons**: When using RMI, the calling side interacts with what's known as a "stub" (a stand-in for the remote object). The called side then uses a "skeleton" to invoke methods on the actual remote object.

- **RMI Registry**: A simple server-side naming registry where remote objects register their names when their services are started. Clients can then look up remote objects and make remote method calls.

## Implementation Steps

### 1. Define the Remote Interface

Your interface should extend the `java.rmi.Remote` interface and define the remote methods. Every method should throw a `RemoteException`.

```java
import java.rmi.Remote;
import java.rmi.RemoteException;

public interface Hello extends Remote {
    String sayHello() throws RemoteException;
}
```

### 3. Implement the Server

After implementing the remote interface, you need to set up the server that will host and provide the RMI service. 

The server will:

1. Create an instance of the remote object.
2. Register this object with the RMI registry so that it can be accessed by the client.

Here's how you can do it:

```java
import java.rmi.Naming;
import java.rmi.RemoteException;

public class HelloServer {
    public static void main(String args[]) {
        try {
            HelloImpl obj = new HelloImpl();
            Naming.rebind("//localhost/HelloServer", obj);
            System.out.println("HelloServer bound in registry");
        } catch (Exception e) {
            System.out.println("HelloServer error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
```

### 4. Create the Client

Once the server is set up and the remote object is bound to the RMI registry, the next step is to create a client that will access this remote object and invoke its methods.

Here's how you can implement the client:

```java
import java.rmi.Naming;

public class HelloClient {
    public static void main(String args[]) {
        try {
            Hello stub = (Hello) Naming.lookup("//localhost/HelloServer");
            String response = stub.sayHello();
            System.out.println("Response: " + response);
        } catch (Exception e) {
            System.out.println("HelloClient exception: " + e.toString());
            e.printStackTrace();
        }
    }
}
```