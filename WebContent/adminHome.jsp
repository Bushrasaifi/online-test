<%
String email=(String)session.getAttribute("email");
if(email!=null){
	if(!email.equals("admin")){
	    response.sendRedirect("adminLogin.jsp");
	}
}
else{
	response.sendRedirect("adminLogin.jsp");
}
%>

<html>
<head>
<title>Code Warrior</title>
<link rel="stylesheet" type="text/css" href="style.css">

</head>


<body>

    <jsp:include page="header.jsp"></jsp:include>        
    <jsp:include page="navigation.jsp"></jsp:include>  
 
    <div id="section">
        <br/><br/>
        
        <form action="filterQuestions.jsp">
            <table cellpadding="10">
                
                <tr>
                    <td></td>
                    <td><b>Filter Questions:</b>
                        <select name="set" required>
                            <option value="">None</option>
                            <option value="1">Set 1</option>
                            <option value="2">Set 2</option>
                            <option value="3">Set 3</option>
                        </select>
                  </td>
                  <td><input type="submit" value="Filter"/></td>
                </tr>
            </table>
        </form>
        
    </div>
    

</body>

</html>