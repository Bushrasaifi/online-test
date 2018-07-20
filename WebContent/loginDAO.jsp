<%@page import="java.util.LinkedHashMap"%>
<%@page import="com.UserDAO"%>
<%
String id=UserDAO.getUserID((String)session.getAttribute("email"));
LinkedHashMap lhm=(LinkedHashMap)session.getAttribute("all_answers");
UserDAO.setResult(id, lhm);
session.invalidate();
response.sendRedirect("result.jsp");
%>