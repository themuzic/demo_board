<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- <link rel="stylesheet" href="semantic/form.css">
<link rel="stylesheet" href="semantic/semantic.css">
<script src="semantic/semantic.js"></script>
<script src="semantic/form.js"></script>
<script src="semantic/index.js"></script>
<script src="semantic/package.js"></script> -->

<style>
.hide{display: none !important;}
.show{display: block !important;}
.join-modal {
    position: absolute;
    top: 15%;
    left: 37%;
    z-index: 1500;
    background: #fff;
    padding: 30px;
}
.closeBtn {
	position: absolute;
    top: 15px;
    right: 10px;
    width: 20px;
    height: 16px;
    background-position: -281px 0;
    color: rgba(34, 36, 38, 0.15);
}
.closeBtn:hover {
	color: black;
}
.form-label{position: absolute;}
</style>

</head>
<body>

	<div class="join-wrap wrap hide">	
		<div class="join-modal" id="layerDealInformation" style="display: block; border-radius: 12px;">
			<form class="ui form" id="join-form" action="/join" method="post">
				<h4 class="ui dividing header" style="padding-bottom: 1em;">Sign Up</h4>
				<div class="field">
					<label>E-Mail</label>
					<div class="fields">
						<div class="field" style="width: 100%;">
							<input type="text" name="email" id="email" placeholder="E-Mail Address" style="width: 72%;">
							<label id="emailIsUseble" class="form-label"></label>
							<div class="ui button" style="margin-left: 10px;" id="emailCheck">Check</div>
							<input type="hidden" id="checkResult" value="">
						</div>
					</div>
				</div>
				<div class="two fields">
					<div class="field">
						<label>Password</label> <input type="password" name="pwd" id="pwd" placeholder="8~16 characters">
						<label id="pwdIsUseble" class="form-label"></label>
					</div>
					<div class="field">
						<label>Confirm</label> <input type="password" name="pwdC" id="pwdC" placeholder="Confirm">
						<label id="pwdIsUsebleC" class="form-label"></label>
					</div>
				</div>
				<div class="two fields">
					<div class="field">
						<label>Name</label> <input type="text" name="name" placeholder="Name">
					</div>
					<div class="field">
						<label>Birth</label> <input type="text" name="birth" id="birth" placeholder="YYYY-MM-DD">
					</div>
				</div>
				<div class="two fields">
					<div class="field">
						<label>Cell Phone</label> <input type="text" name="phone" id="phone" placeholder="010-xxxx-xxxx">
					</div>
					<div class="field">
						<label>Gender</label>
						<select class="ui fluid dropdown" name="gender" style="width: 100px;">
							<option value=""></option>
							<option value="M">male</option>
							<option value="F">female</option>
						</select>
					</div>
				</div>
				<div class="field">
					<label>Base Resort</label> 
					<select class="ui fluid dropdown" name="base" style="width: 200px;">
						<option value=""></option>
						<option value="notyet">Not yet</option>
						<option value="pheonix">Pheonix PyeongChang</option>
						<option value="welli">Welli Hilli Park</option>
						<option value="high1">High1 Resort</option>
						<option value="yongpyeong">YongPyeong Resort</option>
						<option value="vivaldi">Vivaldi Park</option>
						<option value="jisan">Jisan Forest Resort</option>
						<option value="bears">Bears Town</option>
						<option value="muju">Muju Resort</option>
						<option value="konjiam">Konjiam Resort</option>
					</select>
				</div>
				<br>
				<div align="center">
					<div class="ui button" id="join-submit-btn" tabindex="0">Create an Account</div>
				</div>
			</form>
			<a href="javascript:void(0)" class="closeBtn">X</a>
	
		</div>
		<div class="layer_back"	
			 style="position: fixed; width: 100%; height: 100%; z-index: 1000; background-color: rgb(0, 0, 0); opacity: 0.3; top: 0px; left: 0px; margin: 0px; padding: 0px;"></div>
	</div>

</body>

<script>
	$(function(){
		$('#birth').keypress(onlyNumberInput);
		$('#phone').keypress(onlyNumberInput);
	});
	/* 회원가입 버튼을 누르면 */
	$(document).on('click','#join-submit-btn',function(){
		if(checkJoinForm()){
			$('#join-form').submit();
		}
	});
	/* 이메일 입력 */
	$(document).on('keyup','#email',function(){
		$('#checkResult').val('false');
		var email = $('#email').val();
		if(email.length == 0){
			$('#emailIsUseble').css('color','red');
			$('#emailIsUseble').text('Please enter your E-mail.');
		} else if(validateEmail(email)){
			$('#emailIsUseble').text('');
		} else {
			$('#emailIsUseble').css('color','red');
			$('#emailIsUseble').text('Invalid email format.');
		}
	});
	/* 이메일 중복 검사 */
	$(document).on('click','#emailCheck',function(){
		var email = $('#email').val();
		checkEmailOnly(email);
	});
	/* 비밀번호 유효성검사 */
	$(document).on('keyup','#pwd',function(){
		var pwd = $('#pwd');
		if(pwd.val().length == 0 || pwd.val().length >= 8 && pwd.val().length <= 16) {
			$('#pwdIsUseble').text('');
		} else if(pwd.val().length < 8 || pwd.val().length > 16) {
			$('#pwdIsUseble').css('color','red');
			$('#pwdIsUseble').text('need 8~16 characters');
		}
	});
	/* 비밀번호 확인 검사 */
	$(document).on('keyup','#pwdC',function(){
		var pwd = $('#pwd');
		var pwdC = $('#pwdC');
		console.log(pwd.val());
		console.log(pwdC.val());
		if(pwdC.val() == "") {
			$('#pwdIsUsebleC').text('');
		} else if(pwd.val() != pwdC.val()){
			$('#pwdIsUsebleC').css('color','red');
			$('#pwdIsUsebleC').text('Password do not match.');
		} else if(pwd.val() == pwdC.val()) {
			$('#pwdIsUsebleC').css('color','#2185D0');
			$('#pwdIsUsebleC').text('Password is correct.');
		}
	});
	/* 생년월일 입력 */
	$(document).on('keypress','#birth',function(){
		var birth = $('#birth');
		if(birth.val().length == 4 || birth.val().length == 7){
			birth.val(birth.val()+'-');
		} else if(birth.val().length == 6) {
			if(birth.val().charAt(5) > 1){
				var temp = birth.val().charAt(5);
				birth.val(birth.val().slice(0,-1)+"0"+temp+"-");
			}
		} else if(birth.val().length >= 10) {
			event.preventDefault();
		}
	});
	/* 폰번호 입력하기 */
	$(document).on('keypress','#phone',function(){
		var phone = $('#phone');
		if(phone.val().length == 3 || phone.val().length == 8){
			phone.val(phone.val()+'-');
		} else if(phone.val().length >= 13) {
			event.preventDefault();
		}
	});
	/* 이메일 중복 검사 함수 */
	function checkEmailOnly(email){
		$.ajax({
			url:"/emailCheck",
			type:"POST",
			data:{email:email},
			success:function(result){
				if(result == 'true'){
					$('#checkResult').val('true');
					alertify.alert('','This E-Mail is available.');
				} else {
					$('#checkResult').val('false');
					alertify.alert('','There is an E-Mail already in use.');
				}
			},
			error:function(){
				alertify.alert('', 'Server connection failed');
			}
		});
	}
	/* 이메일 유효성 체크 함수 */
	function validateEmail(email) {
		var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		if (filter.test(email)) {
			return true;
		} else {
			return false;
		}
	}
	/* 숫자만 입력 가능하게 하기 */
	function onlyNumberInput() {
        var key = event.which || event.keyCode;
        if (key && (key <= 47 || key >= 58) && key != 8) {
            event.preventDefault();
        }
	}
	/* 회원가입  submit */
	function checkJoinForm() {
		var obj = document.getElementById('join-form');
		
		if(obj.email.value == "") {
			obj.email.focus();
			alertify.alert('','E-Mail required');
			return false;
		}
		if($('#checkResult').val() != 'true') {
			alertify.alert('','Check E-Mail Please');
			return false;
		}
		if(obj.pwd.value == "") {
			obj.pwd.focus();
			alertify.alert('','Password required');
			return false;
		}
		if(obj.pwd.value.length < 8 || obj.pwd.value.length > 16) {			
			obj.pwd.focus();
			alertify.alert('','Password need 8~16 characters');
			return false;
		}
		if(obj.pwdC.value == "" || obj.pwd.value != obj.pwdC.value) {
			obj.pwdC.focus();
			alertify.alert('','Please enter your password correctly');
			return false;
		}
		if(obj.name.value == "") {
			obj.name.focus();
			alertify.alert('','Name required');
			return false;
		}
		if(obj.birth.value == "") {
			obj.birth.focus();
			alertify.alert('','Birthday required');
			return false;
		}
		if(obj.phone.value == "") {
			obj.phone.focus();
			alertify.alert('','Cell phone required');
			return false;
		}
		if(obj.gender.selectedIndex == 0) {
			obj.gender[0].focus();
			alertify.alert('','Please select a gender');
			return false;
		}
		if(obj.base.selectedIndex == 0) {
			obj.base[0].focus();
			alertify.alert('','Please select a base resort');
			return false;
		}
		return true;		
	}

</script>

</html>