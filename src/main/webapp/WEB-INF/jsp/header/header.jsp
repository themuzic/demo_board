<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Demo_Board</title>

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
#sessionAlert:hover{cursor: pointer;}
#demoBoard:hover{cursor: pointer;}
</style>
</head>
<body>
	<c:set var="contextPath" value="${springMacroRequestContext.contextPath}" scope="application"/>
	<div class="ui blue floating message" id="sessionAlert" style="position: absolute; width: 100%; opacity: 0.7; color: black;
																text-align: center; margin: 0; display: none;"></div>
	<div id="header">
		<h1 align="center" id="demoBoard">Demo_Board</h1>
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
				<span style="margin-right: 15px; ">
					<span style="background: red; color:white; 
								width: 21px; height: 21px;
							    border: 1px solid; line-height: 19px;
							    box-sizing: border-box; display: inline-block;
							    text-align: center; border-radius: 30px;
							    position: relative; top: -10px;
							    left: 33px; z-index: -1;" id="alertNumber">0</span>
					<i class="bell outline icon mgr15" id="alertIcon" style="color:black;"></i>
				</span>
				<span id="modify" class="hb" style="margin-right: 5px;">Modify</span> | 
				<span id="signOut" class="hb" style="margin-left: 5px;" onclick="location.href='/logout'">Sign Out</span>
			</c:if>
		</div>
	</div>
	
</body>

<script>
	var socket = null;
	$(function(){
		if('${loginUser}' != ''){
			connectWS();
		}
	});
	/* 상당 demoBoard 누르면 */
	$('#demoBoard').click(function(){
		location.href="/";
	});
	/* 로그인 버튼 누르면 */
	$(document).on('click','#login-submit-btn',function(){
		if(checkLoginForm()){
			$('#login-form').submit();
		}
	});
	/* 댓글 알림 누르면 */
	$(document).on('click','#sessionAlert',function(){
		viewDetail($('#goNumber').val());
	});
	/* 로그인 form check function */	
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
	/* WebSocket */	
	function connectWS() {
		console.log('socket접속시도');
		var ws = new WebSocket("ws://localhost:8282/replyEcho");
		socket = ws;
		
		ws.onopen = function(event){
			console.log('connection opened');
		};
		
		ws.onmessage = function(event){
			console.log("Received Message : "+event.data);
			var sessionAlert = $('#sessionAlert');
			sessionAlert.html(event.data);
			sessionAlert.slideDown();
			setTimeout(function(){
				sessionAlert.slideUp();
			}, 3000);
		};
		
		ws.onclose = function(event){
			console.log('connection closed');
		};
		
		ws.onerror = function(err){
			console.log('error : '+err);
		}
	}
</script>

</html>
