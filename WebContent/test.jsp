<%@page import="java.util.LinkedHashMap"%>
<%@page import="com.UserDAO"%>
<%@page import="com.AdminDAO"%>

<%
String email=(String)session.getAttribute("email");
if(email==null){
    response.sendRedirect("index.jsp");
}

%>

<html>
<head>
<title>Code Warrior</title>
<link rel="stylesheet" type="text/css" href="style.css">

<script src="jquery-1.11.3.js"></script>
</head>

<body onload="startTimer()">

    <script type="text/javascript">
    var question_no=1;
    var question_id=0;
    var max_questions=15;
    
    var timer=1200;
    var min=0;
    var sec=0;
    
    window.onbeforeunload = function() { if(question_no!=max_questions){return "Warning: Your work will be lost!";} };

    function startTimer(){
    	min=parseInt(timer/60);
    	sec=parseInt(timer%60);

    	if(timer<1){
            window.location="resultDAO.jsp";
        }
    		
    	document.getElementById("time").innerHTML = "<b>Time Left: </b>"+min.toString()+":"+sec.toString();
    	timer--;
    	setTimeout(function(){ startTimer(); }, 1000);
    }
    
    $(document).ready(function(){
        $.get('getQuestionDAO.jsp?question_no='+question_no+'&req=first',function(data,status){
            var obj=JSON.parse(data);
            question_id=obj.id;
            $('#question').html('<b>Question '+question_no+': </b><br/>'+obj.question);
            $('#a').html('<b>A:</b><input type="radio" name="answer" value="A">'+obj.a);
            $('#b').html('<b>B:</b><input type="radio" name="answer" value="B">'+obj.b);
            $('#c').html('<b>C:</b><input type="radio" name="answer" value="C">'+obj.c);
            $('#d').html('<b>D:</b><input type="radio" name="answer" value="D">'+obj.d);
        });
        
        if(question_no==1){
        	$('#back').hide();
        }
        else{
        	$('#back').show();
        }
        
        if(question_no==max_questions){
            $('#next').hide();
        }
        else{
            $('#next').show();
        }
        
        if(question_no!=max_questions){
            $('#submit').hide();
        }
        else{
            $('#submit').show();
        }
        
        $('#next').click(function(){
            var answer=$('input[name=answer]:checked').val();
            var s=$('input[name=answer]:checked').size();
        	
            if(s==0){
        		alert("Please select answer for this question");
        	}
        	else{
        	question_no++;
        	$.get('getQuestionDAO.jsp?question_no='+question_no+'&question_id='+question_id+'&answer='+answer,function(data,status){
                var obj=JSON.parse(data);
                question_id=obj.id;
                $('#question').html('<b>Question '+question_no+': </b><br/>'+obj.question);
                $('#a').html('<b>A:</b><input type="radio" name="answer" value="A">'+obj.a);
                $('#b').html('<b>B:</b><input type="radio" name="answer" value="B">'+obj.b);
                $('#c').html('<b>C:</b><input type="radio" name="answer" value="C">'+obj.c);
                $('#d').html('<b>D:</b><input type="radio" name="answer" value="D">'+obj.d);
            });
        	
        	if(question_no==1){
                $('#back').hide();
            }
            else{
                $('#back').show();
            }
            
            if(question_no==max_questions){
                $('#next').hide();
            }
            else{
                $('#next').show();
            }
            
            if(question_no!=max_questions){
                $('#submit').hide();
            }
            else{
                $('#submit').show();
            }
        	}
        });
        
        $('#submit').click(function(){
        	   var answer=$('input[name=answer]:checked').val();
               var s=$('input[name=answer]:checked').size();
               
               if(s==0){
                   alert("Please select answer for this question");
               }
               else{
            	   $.post('getQuestionDAO.jsp?question_no='+question_no+'&question_id='+question_id+'&answer='+answer+"&req=last");
            	   window.location='resultDAO.jsp';
               }
        });
        
        
        $('#back').click(function(){
            question_no--;
            var answer=$('input[name=answer]:checked').val();
            
            $.get('getQuestionDAO.jsp?question_no='+question_no+'&question_id='+question_id+'&answer='+answer,function(data,status){
                var obj=JSON.parse(data);
                question_id=obj.id;
                $('#question').html('<b>Question '+question_no+': </b><br/>'+obj.question);
                $('#a').html('<b>A:</b><input type="radio" name="answer" value="A" required>'+obj.a);
                $('#b').html('<b>B:</b><input type="radio" name="answer" value="B">'+obj.b);
                $('#c').html('<b>C:</b><input type="radio" name="answer" value="C">'+obj.c);
                $('#d').html('<b>D:</b><input type="radio" name="answer" value="D">'+obj.d);
            });
            
            if(question_no==1){
                $('#back').hide();
            }
            else{
                $('#back').show();
            }
            
            if(question_no==max_questions){
                $('#next').hide();
            }
            else{
                $('#next').show();
            }
            
            if(question_no!=max_questions){
                $('#submit').hide();
            }
            else{
                $('#submit').show();
            }
        });
        
     });

    </script>

    <jsp:include page="header.jsp"></jsp:include>        
        
    <div id="section">
        <p id="time"></p>
        <p id="test"></p>
        <br/>
        <p id="question"></p><br/>
        <p id="a"></p>
        <p id="b"></p>
        <p id="c"></p>
        <p id="d"></p>
        
        <br/>
        <button id="next">Next</button>&nbsp;
        <button id="submit">Submit</button>
            
    </div>
    
</body>

</html>