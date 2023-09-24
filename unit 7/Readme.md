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


## Generic Servlet README
`GenericServlet` is an abstract class that provides an implementation for the `Servlet` interface. Unlike the more commonly used HttpServlet which is specific to HTTP protocols, GenericServlet can be used for any type of protocol. It provides life-cycle methods like `init()`, `service()`, and `destroy()` which you can override to define behavior during these life-cycle events.

### Advantages:
1. `Protocol independent`: Can be used when the servlet doesn't need to handle HTTP-specific tasks.
2. `Versatile`: Suitable for various protocols other than HTTP.
### Disadvantages:
1. `Lacks HTTP-specific methods`: Doesn't offer the convenience methods of HttpServlet like doGet(), doPost(), etc.
2. `Less common`: Not as frequently used as HttpServlet for web applications.

```
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/genericServlet")
public class ExampleGenericServlet extends GenericServlet {
    
    @Override
    public void init() throws ServletException {
        // Initialization code here
    }

    @Override
    public void service(ServletRequest request, ServletResponse response) 
      throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        out.println("<html>");
        out.println("<head><title>Generic Servlet Example</title></head>");
        out.println("<body>");
        out.println("<h2>Welcome to the Generic Servlet Example</h2>");
        out.println("</body>");
        out.println("</html>");
    }

    @Override
    public void destroy() {
        // Cleanup resources, if needed.
    }
}

```

### web.xml

```
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee
                             http://xmlns.jcp.org/xml/ns/javaee/web-app_3_1.xsd"
         version="3.1">

    <servlet>
        <servlet-name>ExampleGenericServlet</servlet-name>
        <servlet-class>path.to.your.ExampleGenericServlet</servlet-class>
    </servlet>

    <servlet-mapping>
        <servlet-name>ExampleGenericServlet</servlet-name>
        <url-pattern>/genericServlet</url-pattern>
    </servlet-mapping>

</web-app>

```

```
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private List<Student> students = new ArrayList<>();

	{
		students.add(new Student(1, "Alice", 20));
		students.add(new Student(2, "Bob", 21));
		students.add(new Student(3, "Charlie", 22));
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		resp.setContentType("text/html");
		PrintWriter out = resp.getWriter();
//	        resp.setContentType("application/json");
//	        PrintWriter out = resp.getWriter();
//	        
//	        StringBuilder json = new StringBuilder("[");
//	        for (int i = 0; i < students.length; i++) {
//	            Student student = students[i];
//	            json.append("{")
//	                .append("\"id\":").append(student.getId()).append(",")
//	                .append("\"name\":\"").append(student.getName()).append("\",")
//	                .append("\"age\":").append(student.getAge())
//	                .append("}");
//	            
//	            if (i < students.length - 1) {
//	                json.append(",");
//	            }
//	        }
//	        json.append("]");
//	        
//	        out.print(json.toString());
//	        out.flush();
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("application/json");
//
//	        Student student = gson.fromJson(req.getReader(), Student.class); // Parses the incoming JSON to a Student object
//	        students.add(student);

		resp.getWriter().write("success"); // Sends a success response back
	}

	@Override
	protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("application/json");
		resp.getWriter().write("success"); // Sends a success response back

	}

}

```

### HttpSession in Servlet
**Introduction:**

`HttpSession` is an integral part of Java's Servlet API, providing a way to identify a user across multiple page requests or visitations. It primarily helps in maintaining the user's session and can store data about the user.

**Features:**

1. `Persistence`: HttpSession persists data between requests in a web application.

2. `Timeout`: Sessions can be configured to expire after a certain period of inactivity.

3. `Platform-independent`: Since it's part of the Java Servlet API, it can run on any servlet container.

4. `Security`: Data stored in an HttpSession is server-side and is not exposed directly to the client.

```
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SessionExample")
public class SessionExample extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        // Retrieve or create HttpSession
        HttpSession session = request.getSession(true);

        // Check if there's a counter in this session
        Integer count = (Integer) session.getAttribute("count");

        if (count == null) {
            count = 1;  // initialize the session counter
        } else {
            count++;  // increment the session counter
        }

        // Update the session with the new counter value
        session.setAttribute("count", count);

        out.println("<html>");
        out.println("<body>");
        out.println("<h1>Session Counter: " + count + "</h1>");
        out.println("</body>");
        out.println("</html>");

        out.close();
    }
}

```
 
## Cookies in Servlet

### Introduction:

`Cookies` are small pieces of data that servers send to the user's web browser, allowing the server to remember information about the user's session. In Java Servlets, the `javax.servlet.http.Cookie` class provides methods for setting and retrieving cookie data.

### Features:
1. `State Management`: Cookies allow web applications to manage user state across requests without requiring server-side session management.

2. `Persistence`: Some cookies can persist across browser sessions, allowing for longer-term data storage.

3. `Limited Size`: Each cookie can store up to 4KB of data. If you need to store more, consider using multiple cookies or alternative methods.

4. `Security`: Cookies can be marked as secure and HttpOnly, increasing their security against potential attacks.

### Types of Servlet

1. URL Rewriting
2. HTML Hidden Field
3. Session Management API


### URL Rewriting

URL rewriting is a technique used to maintain the state of an object between client requests when cookies are disabled. In URL rewriting, the session state is embedded within the URL path of the next request.


```
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class URLRewritingExample extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Simulate generating a unique session ID
        String sessionId = "123456";

        out.println("<html>");
        out.println("<body>");

        // Check for existing session ID in the request
        String existingSessionId = request.getParameter("sessionId");
        if (existingSessionId != null) {
            out.println("<h1>Existing Session ID: " + existingSessionId + "</h1>");
        } else {
            out.println("<h1>No Session ID found. Assigning new ID.</h1>");
        }

        out.println("<h2>Click the link below:</h2>");
        // Embedding the session ID into the URL for the next request
        out.println("<a href='" + response.encodeURL("URLRewritingExample?sessionId=" + sessionId) + "'>Click Here</a>");

        out.println("</body>");
        out.println("</html>");

        out.close();
    }
}


```

```
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Testing extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Simulate generating a unique session ID
        String sessionId = "123456";

        out.println("<html>");
        out.println("<body>");

        // Check for existing session ID in the request
        String existingSessionId = request.getParameter("sessionId");
        if (existingSessionId != null) {
            out.println("<h1>Testing Existing Session ID: " + existingSessionId + "</h1>");
        } else {
            out.println("<h1>Testing No Session ID found. Assigning new ID.</h1>");
        }

        out.println("<h2>Click the link below:</h2>");
        // Embedding the session ID into the URL for the next request
        out.println("<a href='" + response.encodeURL("users?sessionId=" + sessionId) + "'>Click Here</a>");

        out.println("</body>");
        out.println("</html>");

        out.close();
    }
}

```

### HTML Hidden Field in Servlets
Hidden fields in HTML forms allow developers to send additional data back to the server without displaying it on the web page. These fields can be useful for maintaining state between client requests, especially when session tracking is needed.


```
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HiddenFieldExample extends HttpServlet {

    private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Retrieve the hidden field value
        String hiddenValue = request.getParameter("hiddenData");
        
        out.println("<html>");
        out.println("<body>");
        out.println("<h1>Hidden Field Example</h1>");

        if (hiddenValue != null) {
            out.println("<h2>Retrieved Hidden Value: " + hiddenValue + "</h2>");
        } else {
            out.println("<h2>No Hidden Value found.</h2>");
        }

        out.println("<form action='test' method='get'>");
        // Setting a hidden field with a value
        out.println("<input type='hidden' name='hiddenData' value='ThisIsHiddenValue'>");
        out.println("<input type='submit' value='Submit Form'>");
        out.println("</form>");

        out.println("</body>");
        out.println("</html>");
        out.close();
    }
}


```

### RequestDispatcher

## Introduction
`RequestDispatcher` is an interface provided by the Servlet API to handle server-side include and forward requests. One of the primary use-cases is forwarding the request from one servlet to another, without the client being aware of the change in URL.

```
package requestdispatcherexample;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DispatcherServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward request to the target servlet
        RequestDispatcher dispatcher = request.getRequestDispatcher("/target");
        dispatcher.forward(request, response);
        
    }
}


```

```

package requestdispatcherexample;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TargetServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        out.println("<h1>You've reached the target servlet!</h1>");
    }
}


```


```
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns="http://xmlns.jcp.org/xml/ns/javaee"
	xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_3_1.xsd"
	id="WebApp_ID" version="3.1">
	<display-name>requestdispatcherexample</display-name>
	<welcome-file-list>
		<welcome-file>index.html</welcome-file>
		<welcome-file>index.jsp</welcome-file>
		<welcome-file>index.htm</welcome-file>
		<welcome-file>default.html</welcome-file>
		<welcome-file>default.jsp</welcome-file>
		<welcome-file>default.htm</welcome-file>
	</welcome-file-list>
	
	
	
	<servlet>
		<servlet-name>first</servlet-name>
		<servlet-class>requestdispatcherexample.DispatcherServlet</servlet-class>
	</servlet>
	<servlet-mapping>
		<servlet-name>first</servlet-name>
		<url-pattern>/first</url-pattern>
	</servlet-mapping>
	
	<servlet>
		<servlet-name>target</servlet-name>
		<servlet-class>requestdispatcherexample.TargetServlet</servlet-class>
	</servlet>
	<servlet-mapping>
		<servlet-name>target</servlet-name>
		<url-pattern>/target</url-pattern>
	</servlet-mapping>


</web-app>

```

## Send Redirect

```

package requestdispatcherexample;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SendRedirect extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("https://www.google.com/");
        
    }
}


```
