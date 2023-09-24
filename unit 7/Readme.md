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
### JSP: Java Server Pages
Sun Microsystems introduced **JSP** as an alternative to **Servlets**.

### JSP vs. Servlets

- JSPs are used to develop server-side (or web-based) applications, similar to Servlets.
- Servlets require more steps and time for simple tasks, like displaying a welcome message, while JSPs can be quicker.

#### Advantages of JSP

- JSPs offer better productivity than Servlets.
- With careful design, there's no need to provide Java code in JSPs.

  > **Note:** You can eliminate Java code using JSP action tags, custom tags, or JSTL.

- JSPs allow for separation of business logic and presentation logic.
- JSP technology inherits properties from **ASP (Active Server Pages)**.

### Procedure to Develop a Simple JSP Program

1. JSP programs should have the ".jsp" extension.
2. Place JSPs inside the project folder but outside the `WEB-INF` folder.

#### First Request to the Server:

1. Server invokes the JSP compiler.
  
  > **Note:** Every server vendor provides their own JSP compiler.

2. The JSP compiler translates the `.jsp` program into a Servlet.
3. The Servlet is then compiled.
4. The server creates an object for the compiled Servlet.

  > **Note:** This process happens only once, during the first client request.

#### Second Request to the Server:
The server executes the existing Servlet object.


## Lifecycle of JSP


![JSP Lifecycle](https://www.masterincoding.com/wp-content/uploads/2020/04/jsp-life-cycle.png)

- **Translation**
- **Compilation**
- **Loading**
- **Instantiation**
- **Initialization**
- **Request Processing**
- **Destruction**

A JSP page is converted into a Servlet to service requests. This process, known as the *Lifecycle of JSP*, includes the following steps:

1. **Translation** of JSP to Servlet code.
2. **Compilation** of Servlet to bytecode.
3. **Loading** of the Servlet class.
4. **Instantiation** of the Servlet.
5. **Initialization** by calling the `jspInit()` method.
6. **Request Processing** by calling the `_jspService()` method.
7. **Destruction** by calling the `jspDestroy()` method.

## Steps to Visualize the LifeCycle
1. Configure User Access in Tomcat
Navigate to the tomcat-users.xml file located within the tomcat/conf directory. Add the following roles and user:

```
<role rolename="manager-gui" />
<role rolename="admin-gui" />
<user username="myadmin" password="mypassword" roles="manager-gui,admin-gui" />
```

2. Restart Tomcat
If you have Tomcat running (e.g., from Eclipse), ensure to stop it first.

3. Start Tomcat from the Bin Directory
Navigate to the bin folder within your Tomcat directory and execute:


```
./startup.sh

```
This command will start the Tomcat server.

4. Access the Tomcat Web Interface
Open a browser and visit:
```
http://localhost:8080
```

You should be able to log in using the credentials you configured:

```
Username: myadmin
Password: mypassword

```
After logging in, navigate to the applications section. This is where you can deploy your applications.

5. Generating a WAR File for Your Web App
You can package your web application into a .war file using the following command:

Copy code
jar -cvf MyWebApp.war *
Remember to execute this command from the directory containing your web application's content.


# JSP Scripting Element

JSP Scripting elements are written inside `<% %>` tags. The code inside `<% %>` tags is processed by the JSP engine during the translation of the JSP page. Any other text in the JSP page is considered as HTML code or plain text.

**Example:**
```html
<html>
    <head>
        <title>My First JSP Page</title>
    </head>
    <%
       int count = 0;
    %>
    <body>
        Page Count is <% out.println(++count); %>   
    </body>
</html>
```

# JSP Scripting Elements

| Type          | Syntax          | Description  | Example |
|---------------|-----------------|--------------|---------|
| Scriptlet     | `<% code %>`    | Contains Java code that's executed during the request phase. | `<% int x = 10; %>` |
| Expression    | `<%= code %>`   | Contains expressions that are evaluated and the result is inserted into the output. | `<%= x+5 %>` |
| Declaration   | `<%! code %>`   | Declares variables or methods with a scope of the entire JSP. | `<%! int y = 20; %>` |
| Directive     | `<%@ ... %>`    | Provides directions/instructions for the JSP engine. Can be used to include other files, specify error pages, or import Java packages. | `<%@ page language="Java" contentType="text/html" %>` |
| Action        | `<jsp: ... />`  | XML-styled tags that represent predefined JSP actions. They are used to control the behavior of the JSP engine. | `<jsp:include page="header.jsp" />` |
| Comment       | `<%-- ... --%>` | Defines a comment; contents will not be processed by the JSP engine. | `<%-- This is a JSP comment --%>` |



# JSP Comment Example

JSP allows developers to include comments in their code, which are not processed during page translation and execution. This can be useful for documentation or to temporarily disable a portion of code without removing it. JSP comments are different from HTML comments; they are not visible in the final rendered output.

```
<html>
    <head>
        <title>JSP Comment Example</title>
    </head>
    <body>
        <%-- This is a comment in JSP and it won't be displayed in the final output. --%>
        <% int data = 50; %>
        Data value is: <%= data %>
        <%-- Incrementing the value of data variable --%>
        <%
            data++;
        %>
        After increment, data value is: <%= data %>
    </body>
</html>
```


# JSP Directive Example

JSP directives provide instructions to the JSP container, affecting the overall structure of the generated servlet. Directives can define attributes that provide information about the entire JSP page, import packages, specify error handling pages, or include other files for modularization. There are three main types of directives in JSP: `page`, `include`, and `taglib`.

Here is a sample JSP program that demonstrates the use of various directives:

```
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Date" %>
<%@ include file="header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
    <head>
        <title>JSP Directive Example</title>
    </head>
    <body>
        Current Date and Time: <%= new Date() %><br>
        
        <c:choose>
            <c:when test="${5 > 3}">
                The number 5 is greater than 3.
            </c:when>
            <c:otherwise>
                The number 5 is not greater than 3.
            </c:otherwise>
        </c:choose>
    </body>
</html>

<%@ include file="footer.jsp" %>

```

`header.jsp`

```
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <p>Here is Jsp Header</p>
</body>
</html>

```
`footer.jsp`

```
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <p>Here is Footer Header</p>
</body>
</html>
```

# JSP Scriptlet Example

JSP scriptlets allow you to embed Java code directly within the JSP page. The code inside a scriptlet is executed as part of the servlet's `service` method (more specifically, within the `_jspService` method) when the JSP is requested. The code within a scriptlet is written inside the `<% ... %>` delimiters.

## Example:

Here's a sample JSP page that uses scriptlets to perform a simple calculation:

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
    <head>
        <title>JSP Scriptlet Example</title>
    </head>
    <body>

        <% 
            int a = 5;
            int b = 3;
            int sum = a + b;
        %>

        Sum of <%= a %> and <%= b %> is: <%= sum %>

    </body>
</html>
```


# JSP Expression Example

In JSP, an expression is used to evaluate a single Java expression and insert its value directly into the output. An expression is written between the `<%= ... %>` delimiters. Unlike scriptlets, expressions don't require a semicolon (`;`) at the end, and they can't contain multiple lines of code or statements—only single expressions that return a value.

## Example:

Here's a sample JSP page that demonstrates the use of JSP expressions:

```
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
    <head>
        <title>JSP Expression Example</title>
    </head>
    <body>

        <% int yearOfBirth = 1990; %>
        
        You are <%= 2023 - yearOfBirth %> years old in 2023.

    </body>
</html>

```

# JSP Declaration Example

In JSP, a declaration is used to declare variables or methods at the class level of the generated servlet. A declaration is written between the `<%! ... %>` delimiters. Unlike scriptlets and expressions, declarations are not executed during the request-response cycle but instead are used to declare members (variables or methods) that can be later used within the JSP.

## Example:

Here's a sample JSP page that demonstrates the use of JSP declarations:

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
    <head>
        <title>JSP Declaration Example</title>
    </head>
    <body>

        <%! int counter = 0; %>

        <%! 
            public int incrementCounter() {
                return ++counter;
            }
        %>
        
        Current count: <%= incrementCounter() %>

    </body>
</html>
```


# JSP Implicit Objects

In JSP, there are several predefined objects that you don't need to create explicitly; they are created internally by the JSP container. These objects are known as implicit objects. They are created during the translation phase of JSP to servlet conversion and are available to all JSP pages.

Here are the main JSP implicit objects:

| Object       | Class                                      | Description                                               |
|--------------|--------------------------------------------|-----------------------------------------------------------|
| `request`    | `javax.servlet.http.HttpServletRequest`       | Represents the client's request to the server.            |
| `response`   | `javax.servlet.http.HttpServletResponse`      | Represents the server's response to the client.           |
| `out`        | `javax.servlet.jsp.JspWriter`               | Provides methods to write content to the client.          |
| `session`    | `javax.servlet.http.HttpSession`            | Represents the client's session with the server.          |
| `application`| `javax.servlet.ServletContext`               | Represents the context of the web application.            |
| `config`     | `javax.servlet.ServletConfig`                | Represents the configuration of the servlet or JSP.       |
| `pageContext`| `javax.servlet.jsp.PageContext`              | Provides access to various objects including other implicit objects.|
| `page`       | `java.lang.Object`                          | Represents the instance of the translated servlet class.  |
| `exception`  | `java.lang.Throwable`                       | Represents exceptions that can be caught and handled in the JSP. |

## Example:

Here's a sample JSP snippet that demonstrates the use of some implicit objects:

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>
    <head>
        <title>JSP Implicit Objects Demonstration</title>
    </head>
    <body>

        <!-- request object -->
        Requested URL: <%= request.getRequestURL() %><br/>
        
        <!-- response object (let's set a header for demonstration, though this isn't usually displayed) -->
        <%
            response.setHeader("demoHeader", "demoValue");
        %>
        
        <!-- out object -->
        <% out.println("This is printed using the out object."); %><br/>

        <!-- session object -->
        Current Session ID: <%= session.getId() %><br/>
        <%
            session.setAttribute("demoAttribute", "demoValue");
        %>
        Session Attribute (demoAttribute): <%= session.getAttribute("demoAttribute") %><br/>

        <!-- application object -->
        Application Real Path: <%= application.getRealPath("/") %><br/>

        <!-- config object -->
        Servlet Name (from config): <%= config.getServletName() %><br/>

        <!-- pageContext object -->
        Servlet Context Path (using pageContext): <%= pageContext.getServletContext().getContextPath() %><br/>

        <!-- page object (typically not used directly, but for demonstration) -->
        This JSP page's class name: <%= page.getClass().getName() %><br/>

        <!-- exception object (used in error pages) -->
        <% 
            if (exception != null) {
        %>
        Exception Message: <%= exception.getMessage() %><br/>
        <%
            }
        %>

    </body>
</html>



# Object Scope in JSP

In JSP, the scope of an object determines its lifetime and visibility from various parts of the application. There are four primary scopes available for objects in JSP. Let's explore them with examples:

## **1. Page Scope**

### Description:
- **Duration**: Exists only for the current request.
- **Visibility**: Only accessible within the JSP page where it's created.
- **Usage**: Objects in this scope are automatically destroyed when the response is sent back to the client.

### Example:
```jsp
<%-- This is a JSP page --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Page Scope Example</title>
</head>
<body>
    <% pageContext.setAttribute("pageAttribute", "Page Scope Value"); %>
    Page Attribute: <%= pageContext.getAttribute("pageAttribute") %>
</body>
</html>
```


## Request Scope in JSP

### **Description**:
The `request` scope in JSP is specific to the lifetime of a single client's request. Any attribute stored in this scope is accessible from any JSP or servlet that processes the same request, making it useful for sharing data between resources (like forwarding data between servlets and JSPs). Once the request processing is complete, the objects in this scope are discarded.

### **Characteristics**:
- **Duration**: Lasts for a single client's request, including any forwarded or included JSPs/servlets.
- **Visibility**: Any JSP or servlet that processes the same request can access it.
- **Usage**: Useful for sharing data across resources during the lifetime of a single request. Attributes stored here are destroyed after processing the request.

### **Example**:

```jsp
<%-- This is a JSP page demonstrating request scope --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Request Scope Example</title>
</head>
<body>
    <% request.setAttribute("requestAttribute", "Request Scope Value"); %>
    Request Attribute: <%= request.getAttribute("requestAttribute") %>
</body>
</html>
```

## Session Scope in JSP

### **Description**:
The `session` scope in JSP pertains to a specific user's session across multiple requests to the server. When you store an attribute in the session scope, it remains available and persists across multiple requests from the same client, until the session expires or the attribute is explicitly removed.

### **Characteristics**:
- **Duration**: Lasts across multiple requests until the user's session times out or is invalidated.
- **Visibility**: Any JSP or servlet within the same session can access it.
- **Usage**: Useful for storing user-specific information like user credentials, user preferences, or a user's shopping cart.

### **Example**:

```jsp
<%-- This is a JSP page demonstrating session scope --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Session Scope Example</title>
</head>
<body>
    <% 
       if(session.getAttribute("sessionAttribute") == null) {
           session.setAttribute("sessionAttribute", "Initial Session Value"); 
       }
    %>
    Session Attribute: <%= session.getAttribute("sessionAttribute") %>
    <br/>
    <a href="modifySessionAttribute.jsp">Modify Session Attribute</a>
</body>
</html>
```

## Application Scope in JSP

### **Description**:
The `application` scope in JSP corresponds to the entire lifetime of the web application. Any attribute stored in this scope remains available and persists for as long as the web application is running, making it accessible from any JSP or servlet that is part of the application. It's useful for storing data that should be shared across all users and all requests.

### **Characteristics**:
- **Duration**: Lasts for the entire lifetime of the web application, until the application is stopped or the attribute is explicitly removed.
- **Visibility**: Any JSP or servlet within the same web application can access it.
- **Usage**: Ideal for storing global configuration, shared resources, or data that is common to all users and requests.

### **Example**:

```jsp
<%-- This is a JSP page demonstrating application scope --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Application Scope Example</title>
</head>
<body>
    <% 
       if(application.getAttribute("globalCount") == null) {
           application.setAttribute("globalCount", 0); 
       }
       int count = (Integer)application.getAttribute("globalCount");
       application.setAttribute("globalCount", count + 1);
    %>
    Global Request Count: <%= application.getAttribute("globalCount") %>
    <br/>
    <p>This count will increment for every request from any user to this JSP, illustrating the global nature of the application scope.</p>
</body>
</html>
```

## Processing Forms in JSP

Using JSP, you can create web forms and also handle their submissions. Here's a step-by-step guide.

### **1. Creating a Form in JSP**:

You can design a simple form that collects user information, such as a name and email.

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Form Submission in JSP</title>
</head>
<body>
    <form action="processForm.jsp" method="post">
        Name: <input type="text" name="userName"><br>
        Email: <input type="text" name="userEmail"><br>
        <input type="submit" value="Submit">
    </form>
</body>
</html>
```


### **2. Processing the Form**:

After submission, data is sent to processForm.jsp, where it is processed.

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Form Data Processed</title>
</head>
<body>
    Welcome, <%= request.getParameter("userName") %>!
    <br>
    Your email is: <%= request.getParameter("userEmail") %>
</body>
</html>
```