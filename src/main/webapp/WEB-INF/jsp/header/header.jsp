<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- alertify.js -->
<script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>
<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<!-- summernote 에디터 -->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.css"	rel="stylesheet">
<script	src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.js"></script>
<script	src="https://github.com/summernote/summernote/tree/master/lang/summernote-ko-KR.js"></script>
<!-- CSS -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/alertify.min.css"/>
<!-- Default theme -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/default.min.css"/>
<!-- Semantic UI theme -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/semantic.min.css"/>

<link rel="stylesheet" href="semantic/form.css">
<link rel="stylesheet" href="semantic/semantic.css">
<link rel="stylesheet" href="semantic/icon.css">
<!-- <script src="semantic/semantic.js"></script> -->
<!-- <script src="semantic/form.js"></script> -->
<!-- <script src="semantic/index.js"></script> -->
<!-- <script src="semantic/package.js"></script> -->
<style>
.fl {float: left;}
.fr {float: right;}
#header {padding:50px 20px 0px 20px;}
#sign-div {width: 65%; margin: auto; text-align: right; font-size: 15px;}
.hb:hover{color: blue; cursor: pointer;}
#login-wrap {
	border: 1px solid rgba(34, 36, 38, 0.15);
	width: 200px;
	position: absolute;
	z-index: 10000;
	background: white;
	padding: 15px;
	right: 16%;
    top: 18%;
    display: none;
	}
.alertify .ajs-dialog{
	max-width: 30%;
	background: white;
	text-align: center;
}
a {text-decoration: none;}
</style>
</head>
<body>
	<c:set var="contextPath" value="${springMacroRequestContext.contextPath}" scope="application"/>
	<div id="header">
		<h1 align="center">Demo_Board</h1>
		<div id="sign-div">
			<c:if test="${empty sessionScope.loginUser}">
				<span id="signUp" class="hb" style="margin-right: 5px;">Sign Up</span> | <span id="signIn" class="hb" style="margin-left: 5px;">Sign In</span>
				<br>
				<span id="login-wrap" style="border-radius: 8px;">
					<form class="ui form" id="login-form" action="/login" method="POST">
						<div class="field" style="margin-bottom: 5px;">
						    <div class="fields" style="margin-bottom: 0;">
						    	<div class="field">
						        	<input type="text" name="email" class="sign" placeholder="E-Mail" style="height: 36px;">
						    	</div>
						    </div>
					    </div>		
						<div class="field" style="margin-bottom: 5px;">
						    <div class="fields" style="margin-bottom: 0;">
						    	<div class="field">
						        	<input type="password" name="pwd" class="sign" placeholder="Password" style="height: 36px;">
						    	</div>
						    </div>
					    </div>
					    <div align="center">
						    <div class="ui button" tabindex="0" id="login-submit-btn">Sign In</div>
					    </div>	
					</form>
				</span>
			</c:if>
			<c:if test="${!empty sessionScope.loginUser}">
				<span id="modify" class="hb" style="margin-right: 5px;">Modify</span> | 
				<span id="signOut" class="hb" style="margin-left: 5px;" onclick="location.href='/logout'">Sign Out</span>
			</c:if>
		</div>
	</div>
	
</body>

<script>
	
	$(document).on('click','#login-submit-btn',function(){
		if(checkLoginForm()){
			$('#login-form').submit();
		}
	});
	
	function checkLoginForm() {
		var obj = document.getElementById('login-form');
		
		if(obj.email.value == ""){
			obj.email.focus();
			alertify.alert('','E-Mail required');
			return false;
		}
		if(obj.pwd.value == "") {
			obj.pwd.focus();
			alertify.alert('','Password required');
			return false;
		}
		return true;
	}

</script>

</html>
