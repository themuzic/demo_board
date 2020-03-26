<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<style>
#header {padding:50px 20px 0px 20px;}
#sign-div {width: 57%; margin: auto; text-align: right; font-size: 15px;}
.hb:hover{color: blue; cursor: pointer;}
#login-wrap {
	border: 1px solid rgba(34, 36, 38, 0.15);
	width: 200px;
	position: absolute;
	z-index: 10000;
	background: white;
	padding: 15px;
	right: 21%;
    top: 18%;
    display: none;
	}
</style>
</head>
<body>
	<c:set var="contextPath" value="${springMacroRequestContext.contextPath}" scope="application"/>
	<div id="header">
		<h1 align="center">Demo_Board</h1>
		<div id="sign-div">
			<span id="signUp" class="hb" style="margin-right: 5px;">Sign Up</span> | <span id="signIn" class="hb" style="margin-left: 5px;">Sign In</span>
			<br>
			<span id="login-wrap" style="border-radius: 8px;">
				<form class="ui form">
					<div class="field" style="margin-bottom: 5px;">
					    <div class="fields" style="margin-bottom: 0;">
					    	<div class="field">
					        	<input type="text" name="id" class="sign" placeholder="E-Mail" style="height: 36px;">
					    	</div>
					    </div>
				    </div>		
					<div class="field" style="margin-bottom: 5px;">
					    <div class="fields" style="margin-bottom: 0;">
					    	<div class="field">
					        	<input type="text" name="pwd" class="sign" placeholder="Password" style="height: 36px;">
					    	</div>
					    </div>
				    </div>
				    <div align="center">
					    <div class="ui button" tabindex="0">Sign In</div>
				    </div>	
				</form>
			</span>
		</div>
	</div>
	
	
</body>
</html>
