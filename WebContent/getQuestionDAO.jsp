<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.UserDAO"%>
<%
String question_no=request.getParameter("question_no");
String req=request.getParameter("req");
String set=(String)session.getAttribute("set");
String email=(String)session.getAttribute("email");

if(req!=null){
	if(req.equals("first")){
	String result=UserDAO.getQuestion(question_no,set);
	out.print(result);
	}
	else{
		   String question_id=request.getParameter("question_id");
		    String answer=request.getParameter("answer");
		    LinkedHashMap lhm=(LinkedHashMap)session.getAttribute("all_answers");
		    
		    if(!answer.equals("undefined")){
		          
		          
		          if(lhm==null){
		              lhm=new LinkedHashMap();
		              lhm.put(question_id, answer);
		              session.setAttribute("all_answers", lhm);
		          }
		          else{
		              lhm.put(question_id, answer);
		              session.setAttribute("all_answers", lhm);
		          }
		    }
	
	}
}
else{
	String question_id=request.getParameter("question_id");
	String answer=request.getParameter("answer");
    LinkedHashMap lhm=(LinkedHashMap)session.getAttribute("all_answers");
	
	if(!answer.equals("undefined")){
		  
		  
		  if(lhm==null){
			  lhm=new LinkedHashMap();
			  lhm.put(question_id, answer);
			  session.setAttribute("all_answers", lhm);
		  }
		  else{
			  lhm.put(question_id, answer);
              session.setAttribute("all_answers", lhm);
		  }
	}
	

	String result=UserDAO.getQuestion(question_no, set);
	out.print(result);

}
%>