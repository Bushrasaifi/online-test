<%
String email=(String)session.getAttribute("email");
if(email!=null){
    if(email.equals("admin")){
        response.sendRedirect("adminHome.jsp");
    }
}
%>

<html>
<head>
<title>Code Warrior</title>
<link rel="stylesheet" type="text/css" href="style.css">

</head>


<body>

    <script type="text/javascript">
        function check(){
            if(document.login.password.value.length<5){
                alert("minimum password length must be 5 characters");
                return false;
            }
            
            if(document.login.password.value.length>15){
                alert("maximum password length must be 15 characters");
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
        <form action="adminLoginDAO.jsp" name="login" onsubmit="return check()">
            <table cellpadding="10">
                <tr>
                    <th colspan="2">Admin Login</th>
                </tr>        
                
                <tr>
                    <td><b>Email:</b></td>
                    <td><input type="email" name="email" required/></td>
                </tr>
                
                <tr>
                    <td><b>Password:</b></td>
                    <td><input type="password" name="password" required/></td>
                </tr>
                
                <tr>
                    <td colspan="2" align="center"><input type="submit" value="Login"/></td>
                </tr>
            </table>
        </form>
        </div>
        
    </div>
    

</body>

</html>