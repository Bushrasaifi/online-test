<%@page import="java.util.Random"%>
<%@page import="com.UserDAO"%>
<%
String name=request.getParameter("name");
String email=request.getParameter("email");
String result=UserDAO.registerUser(name,email);





if(result.equals("false")){
	response.sendRedirect("index.jsp?status=false");
}

if(result.equals("registered")){
    response.sendRedirect("home.jsp?status=registered");
}
%>