# SimpleServletContainer

A lightweight servlet container built to deploy and manage Java-based web applications efficiently.

## Features

- **Java Web Application Support**: Designed exclusively for servlet-based web applications.
- **Performance Optimized**: Streamlined operations for faster response times.
- **Secure**: Inbuilt security protocols to ensure safe execution of your applications.
- **Easy Deployment**: Drop in your `.war` files and get going!


![Flow Image](https://media.geeksforgeeks.org/wp-content/uploads/20220110232620/flow5.jpg)


# Introduction to Servlets

Servlets are Java programs that run on a web or application server, acting as a middle layer between a request coming from a web browser or other HTTP client and databases or applications on the HTTP server.

## What is a Servlet?

At its core, a Servlet is a Java class that handles HTTP requests and responses. It's an essential component of Java's solution for building web applications. The Servlet API, provided by Java, allows for the generation of web content via Java classes instead of static HTML files.

## Key Features

1. **Platform Independence**: Servlets are written in Java, and therefore, they're platform-independent. They can run on any web server or application server that supports the servlet specification.
2. **Performance**: Servlets are designed to be fast. Once a servlet is loaded, it remains in the server's memory as a single object instance. Subsequent requests are threaded and processed concurrently, ensuring quick response times.
3. **Security**: Java's inherent security model is extended to Servlets, offering a range of security measures like encryption and HTTPS support.
4. **Persistence**: Unlike HTTP, which is stateless, Servlets can maintain state (session data) over multiple requests from the same client.
5. **Integrability**: Servlets can interact seamlessly with other Java technologies, such as JDBC for database access.

## Lifecycle of a Servlet

1. **Initialization**: When a servlet is first invoked, the `init` method is called. This method is called only once and is used for setup procedures, like database connections.
2. **Service**: The `service` method handles and responds to client requests. This method calls appropriate methods (`doGet`, `doPost`, etc.) based on the HTTP request type.
3. **Destruction**: The `destroy` method is called once when the servlet is taken out of service. This method is a chance to close database connections, halt threads, or perform other cleanup tasks.

## Why Use Servlets?

- **Dynamic Content**: Servlets allow for dynamic web page content creation based on user input, database content, or other data sources.
- **Efficiency**: They only need to be loaded once into the memory and can handle multiple requests concurrently using multithreading.
- **Java's Ecosystem**: Servlets can leverage Java's vast library ecosystem for functionalities ranging from database connections to advanced data processing.



# Creating a Servlet Program with XML Configuration in Eclipse

Follow these steps to create a servlet program using XML configuration in Eclipse IDE:

## 1. Prerequisites:

- Install [Eclipse IDE for Java EE Developers](https://www.eclipse.org/downloads/packages/).
- Install [Apache Tomcat](https://tomcat.apache.org/download-90.cgi) or another servlet container.

## 2. Create a New Dynamic Web Project:

1. Open Eclipse.
2. Go to `File` > `New` > `Dynamic Web Project`.
3. Name the project (e.g., "ServletDemo").
4. Choose a target runtime (like Apache Tomcat).
5. Set the Dynamic web module version to `4.0` or suitable.
6. Click `Finish`.

## 3. Add Servlet Class:

1. In the `Project Explorer`, right-click on `src` folder > `New` > `Class`.
2. For the package, enter `com.example`.
3. For the class name, enter `MyServlet`.
4. Click `Finish`.
5. Extend this class from `HttpServlet` and override the `doGet` method, filling in with your desired logic:

```java
package com.example;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MyServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<h1>Hello, World!</h1>");
    }
}
```


## 4. Configure Servlet in web.xml:
1. In Project Explorer, navigate to WebContent > WEB-INF and open web.xml.
2. Add the servlet and servlet-mapping configuration:

```
<servlet>
    <servlet-name>MyServlet</servlet-name>
    <servlet-class>com.example.MyServlet</servlet-class>
</servlet>

<servlet-mapping>
    <servlet-name>MyServlet</servlet-name>
    <url-pattern>/hello</url-pattern>
</servlet-mapping>

```

## 5. Run Your Servlet:
1. Right-click on your project in Project Explorer.
2. Choose Run As > Run on Server.
3. Select your server (e.g., Tomcat) and click Finish.
4. Eclipse will start the server and open a browser or browser tab.
5. Navigate to http://localhost:8080/ServletDemo/hello.
