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

### 2. Implement the Remote Interface

After defining the remote interface, the next step is to provide an implementation for it. This class, often referred to as the "remote object," will perform the actual operations when a remote method is invoked.

#### Steps to Implement the Remote Interface:

1. **Extend `UnicastRemoteObject`**: The implementation class should extend the `java.rmi.server.UnicastRemoteObject` class. This is required to create and export a remote object.

2. **Implement the Remote Interface**: Declare that your class implements the previously defined remote interface.

3. **Provide a Constructor**: The constructor of this class should handle the potential `RemoteException` that might be thrown. This is often done by simply calling the superclass constructor using `super()`.

4. **Implement the Remote Methods**: Provide concrete implementations for all the methods declared in the remote interface.

Here's a sample implementation based on the `Hello` interface:

```java
import java.rmi.server.UnicastRemoteObject;
import java.rmi.RemoteException;

public class HelloImpl extends UnicastRemoteObject implements Hello {
    
    // Constructor
    public HelloImpl() throws RemoteException {
        super();
    }

    // Implement the remote method
    @Override
    public String sayHello() throws RemoteException {
        return "Hello, world!";
    }
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

## Compilation & Execution


### Execution Steps

1. **Compile all the Java files:**:
   Navigate to the directory containing your Java files (Hello.java, HelloImpl.java, HelloServer.java, and HelloClient.java) and compile them using:
   ```bash
   javac -source 11 -target 11 *.java
   ```


2. **Generate the Stub files:**:
   Use the rmic tool to generate stubs for your remote object implementation::
   ```bash
   rmic HelloImpl
   ```

3. **Start the RMI Registry**:
   After compiling the Java files, navigate to the directory containing the compiled `.class` files. Start the RMI registry either in the background or in a new terminal window:
   ```bash
   rmiregistry &
   ```

4. **Start the Server:**:
   In the original terminal, start the server application:
   ```bash
   java HelloServer
   ```
5. **Run the Client:**:
   Once the server is running and the remote object is registered, you can start the client in a separate terminal:
   ```bash
   java HelloClient
   ```            


## Introduction to CORBA

**Common Object Request Broker Architecture (CORBA)** is an architecture and specification for creating, distributing, and managing distributed program objects in a network. It allows programs at different locations and developed by different vendors to communicate in a network. CORBA uses an object-oriented model, and although the details can be quite complex, the main idea is to allow invocation of methods on a remote object, similar to making method calls on local objects.

---

## Implementing CORBA

### Prerequisites:

1. Install the Java Development Kit (JDK).
2. Install an ORB (Object Request Broker). One of the most common ORBs for Java is the Java IDL that comes with the JDK.

### Steps:

1. **Define the Interface in IDL (Interface Definition Language)**:
   Create a file named `Hello.idl` with the following content:

   ```idl
   interface Hello {
       string sayHello();
   };
   ```

   compile with `idlj -fall Hello.idl`
   add corba jar after that
2. **Implement the Server**:
   After compiling the IDL file, you'll need to implement the server. Extend the generated `HelloPOA` class and implement the `sayHello` method:

   ```java
   public class HelloImpl extends HelloPOA {
       @Override
       public String sayHello() {
           return "Hello, CORBA!";
       }
   } 
   ```
3. **Create Server Main Class**:
   After compiling the IDL file, you'll need to implement the server. Extend the generated `HelloPOA` class and implement the `sayHello` method:

   ```java
   public class HelloServer {
    public static void main(String[] args) {
        try {
            ORB orb = ORB.init(args, null);
            HelloImpl helloImpl = new HelloImpl();
            orb.connect(helloImpl);
            org.omg.CORBA.Object objRef = orb.resolve_initial_references("NameService");
            NamingContext ncRef = NamingContextHelper.narrow(objRef);
            NameComponent[] path = { new NameComponent("Hello", "") };
            ncRef.rebind(path, helloImpl);
            System.out.println("HelloServer ready and waiting...");
            orb.run();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
   }
   ```
4. **Implement the Client:**:
   After compiling the IDL file, you'll need to implement the server. Extend the generated `HelloPOA` class and implement the `sayHello` method:

   ```java
   public class HelloClient {
    public static void main(String[] args) {
        try {
            ORB orb = ORB.init(args, null);
            org.omg.CORBA.Object objRef = orb.resolve_initial_references("NameService");
            NamingContextExt ncRef = NamingContextExtHelper.narrow(objRef);
            Hello helloRef = HelloHelper.narrow(ncRef.resolve_str("Hello"));
            System.out.println(helloRef.sayHello());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
   ```         