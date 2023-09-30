<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="net.codejava.javaee.bookstore.Book"%>
<html>
<head>
<title>Books Store Application</title>
</head>
<body>
	<center>
		<h1>Books Management</h1>
		<h2>
			<a href="new">Add New Book</a> &nbsp;&nbsp;&nbsp; <a href="list">List
				All Books</a>
		</h2>
	</center>
	<div align="center">
		<table border="1" cellpadding="5">
			<caption>
				<h2>List of Books</h2>
			</caption>
			<tr>
				<th>ID</th>
				<th>Title</th>
				<th>Author</th>
				<th>Price</th>
				<th>Actions</th>
			</tr>
			<%
			List<?> listBook = (List<?>) request.getAttribute("listBook");
			for (Object obj : listBook) {
				Book book = (Book) obj;
			%>
			<tr>
				<td><%=book.getId()%></td>
				<td><%=book.getTitle()%></td>
				<td><%=book.getAuthor()%></td>
				<td><%=book.getPrice()%></td>
				<td><a href="edit?id=<%=book.getId()%>">Edit</a>
					&nbsp;&nbsp;&nbsp;&nbsp; <a href="delete?id=<%=book.getId()%>">Delete</a>
				</td>
			</tr>
			<%
			}
			%>
		</table>
	</div>
</body>
</html>
