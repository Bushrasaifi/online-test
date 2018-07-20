<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.AdminDAO"%>
<%@page import="org.json.simple.JSONArray"%>
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
          <table cellpadding="10" border="1">
                <tr>
                    <th>S.No.</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Points</th>    
                    
                </tr>
            
        <%
        JSONArray array=AdminDAO.getResult();
        JSONObject obj;
                
        for(int i=0;i<array.size();++i){
            obj=(JSONObject)array.get(i);
        
        %>    
                
                <tr>
                    <td>
                    <%=i+1%>
                    </td>
                    
                    <td>
                    <%=obj.get("name")%>
                    </td>

                    <td>
                    <%=obj.get("email")%>
                    </td>

                    <td>
                    <%=obj.get("points") %>
                    </td>
                    
                </tr>
                                
        <%} %>
            </table> 
            
        
    </div>

</body>

</html>