# **Java Essentials Guide**

---

## **1. Java Architecture**

Java operates on the principle of 'Write Once, Run Anywhere'. The architecture can be described as:

- **Java Source Code (.java files)**: Code written by developers.
- **Java Compiler**: Converts source code to bytecode.
- **Java Bytecode (.class files)**: The platform-independent intermediate code.
- **Java Virtual Machine (JVM)**: An abstract computing machine that runs bytecode. There's a specific JVM for each platform.

---

## **2. Java Buzzwords**

Java is characterized by several defining buzzwords:

- **Simple**: Intuitive and user-friendly.
- **Object-Oriented**: Java uses the OOP paradigm for organized, modular coding.
- **Platform Independent**: Code written in Java can run on any device with a JVM.
- **Secure**: Java comes fortified with inherent security features.
- **Architecture Neutral**: No architectural dependency ensures Java's portability.
- **Portable**: With JVM, bytecode is compatible with any OS or device.
- **Robust**: Equipped with robust memory management and error-handling capabilities.
- **Multithreaded**: Designed to execute several threads simultaneously.
- **High Performance**: Bytecode nearly matches the performance of native code.
- **Distributed**: Tailored for the internet's distributed environment.

---

## **3. Path and ClassPath Variables**

- **Path Variable**: This OS environment variable locates executable files. For Java, the Path variable ensures Java tools like `javac` and `java` run from any directory in the command line.
- **ClassPath Variable**: Point ClassPath to the directory or a JAR where .class files reside. The JVM uses ClassPath to locate and load classes during runtime.

---

## **4. Sample Java Program**

Here's a Java program that outputs "Hello, World!" on the console:

```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
```

## **5. Compiling and Running Java Programs**

1. **Compiling**: Compile your Java source code using the `javac` command:
   ```bash
   javac HelloWorld.java

2. **Running**: Execute your Java program using the `java` command::
   ```bash
   javac HelloWorld.java

# **Java Essentials: Arrays & For-Each Loop**

---

## **1. Arrays**

Arrays in Java are homogeneous data structures that can store multiple values of the same type in contiguous memory locations.

### **Declaration**:
You can declare an array by specifying its type followed by square brackets.
```java
int[] arrayName;
```

### **Initialization**:
Arrays can be initialized at the time of declaration or using the `new` keyword.
```java
int[] numbers = {1, 2, 3, 4, 5}; // during declaration
numbers = new int[5];             // using new keyword

