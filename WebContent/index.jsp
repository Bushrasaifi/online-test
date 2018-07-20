<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>CodeWarrior</title>
<link rel="stylesheet" type="text/css" href="style.css">

</head>
<body>

<body>

	<script type="text/javascript">
    	function check(){
    		if(document.register.name.value.length<5){
    			alert("minimum name length must be 5 characters");
    			return false;
    		}
    		
            if(document.register.name.value.length>50){
                alert("maximum name length must be 50 characters");
                return false;
            }

            if(document.register.email.value.length>50){
                alert("maximum email length must be 50 characters");
                return false;
            }            
    	}
	</script>

    <jsp:include page="header.jsp"></jsp:include>        
        
    <div id="section">
    
        <br/><br/>
        
        <div align="center">
        <form action="loginDaao.jsp" name="register" onsubmit="return check()">
            <table cellpadding="10">
                <tr>
                    <th colspan="2">Student Login</th>
                </tr>        
                
                <tr>
                    <td><b>Name:</b></td>
                    <td><input type="text" name="name" required/></td>
                </tr>
                
                <tr>
                    <td><b>Email:</b></td>
                    <td><input type="email" name="email" required/></td>
                </tr>
                
                <tr>
                    <td colspan="2" align="center"><input type="submit" value="Login"/></td>
                </tr>
            </table>
        </form>
        <a href="register.jsp">New user click here!</a>
        </div>
</div>
 <%
        String status=request.getParameter("status");
        
        if(status!=null){
        	if(status.equals("false")){%>
        		<p style="color:red">email not found please register first!</p>
        	<%}
        	
        }
        %>
        <div id="footer"><h1>lets test your proramming skills!!</h1></div>

</body>
</html>