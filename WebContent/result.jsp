<%@page import="com.UserDAO"%>
<%@page import="com.AdminDAO"%>


<html>
<head>
<title>Code Warrior</title>
<link rel="stylesheet" type="text/css" href="style.css">

</head>

<body>

    <script type="text/javascript">
        window.onbeforeunload = function() { return "Warning: Your work will be lost!"; };
    </script>

    <jsp:include page="header.jsp"></jsp:include>        
        
    <div id="section">
    <h2>Test Finished:</h2>
    <ul>
      <li>Your result is saved.</li>
      <li>Please wait while others finish their test.</li>
      <li>Please don't press back, close or reload this window.</li>
    </ul>  
    
    <br/>
    <h2>Happy Coding!! :) :)</h2>
    </div>
    
</body>

</html>