<%@page import="com.AdminDAO"%>
<%
String id=request.getParameter("id");
String set=request.getParameter("set");
String result=AdminDAO.deleteQuestion(id);

if(result.equals("true")){
	response.sendRedirect("filterQuestions.jsp?set="+set+"&status=true");
}
else{
	response.sendRedirect("filterQuestions.jsp?set="+set+"&status=false");
}
%>