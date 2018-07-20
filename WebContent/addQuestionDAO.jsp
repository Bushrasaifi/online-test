<%@page import="com.AdminDAO"%>
<%
StringBuffer text = new StringBuffer(request.getParameter("question"));
String a=request.getParameter("a");
String b=request.getParameter("b");
String c=request.getParameter("c");
String d=request.getParameter("d");
String answer=request.getParameter("answer");
String set=request.getParameter("set");


int loc = (new String(text)).indexOf('\n');
while(loc > 0){
    text.replace(loc, loc+1, "<br>");
    loc = (new String(text)).indexOf('\n');
}

loc = (new String(text)).indexOf(' ');
while(loc > 0){
    text.replace(loc, loc+1, "&nbsp;");
    loc = (new String(text)).indexOf(' ');
}

String question=new String(text);
String result=AdminDAO.addQuestion(question, a, b, c, d, set, answer);

if(result.equals("true")){
    response.sendRedirect("addQuestion.jsp?status=true");
}else{
	response.sendRedirect("addQuestion.jsp?status=false");
}
	
%>