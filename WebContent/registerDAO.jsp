<%@page import="java.util.Random"%>
<%@page import="com.UserDAO"%>
<%
String name=request.getParameter("name");
String email=request.getParameter("email");
String result=UserDAO.putData(name,email);



if(result.equals("true")){
	Random random=new Random();
	int i=random.nextInt(3)+1;
	session.setAttribute("email",email);
	session.setAttribute("set", ""+i);
	response.sendRedirect("index.jsp");
}

if(result.equals("false")){
	response.sendRedirect("index.jsp?status=false");
}

if(result.equals("registered")){
    response.sendRedirect("register.jsp?status=registered");
}
%>