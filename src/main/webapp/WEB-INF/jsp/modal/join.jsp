<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="semantic/form.css">
<link rel="stylesheet" href="semantic/semantic.css">
<script src="semantic/semantic.js"></script>
<script src="semantic/form.js"></script>
<script src="semantic/index.js"></script>
<script src="semantic/package.js"></script>

<style>
.hide{display: none !important;}
.show{display: block !important;}
.join-modal {
    position: absolute;
    top: 15%;
    left: 37%;
    z-index: 1500;
    /* border: 1px solid #8d8d8d; */
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
</style>

</head>
<body>

	<div id="join-layer" class="join-wrap hide">	
		<div class="join-modal" id="layerDealInformation" style="display: block; border-radius: 12px;">
			<form class="ui form" id="join-form" action="/join" method="post">
				<h4 class="ui dividing header" style="padding-bottom: 1em;">Sign Up</h4>
				<div class="field">
					<label>E-Mail</label>
					<div class="fields">
						<div class="field" style="width: 100%;">
							<input type="text" name="email" placeholder="E-Mail Address" style="width: 100%;">
							<label id="idIsUseble"></label>
						</div>
					</div>
				</div>
				<div class="two fields">
					<div class="field">
						<label>Password</label> <input type="password" id="pwd" name="pwd" placeholder="8~16 characters">
						<label id="pwdIsUseble"></label>
					</div>
					<div class="field">
						<label>Confirm</label> <input type="password" id="pwdC" name="pwdC" placeholder="Confirm">
						<label id="pwdIsUsebleC"></label>
					</div>
				</div>
				<div class="two fields">
					<div class="field">
						<label>Name</label> <input type="text" id="name" name="name" placeholder="Name">
					</div>
					<div class="field">
						<label>Birth</label> <input type="text" id="birth" name="birth" placeholder="YYYY-MM-DD">
					</div>
				</div>
				<div class="two fields">
					<div class="field">
						<label>Cell Phone</label> <input type="text" name="phone" placeholder="010-xxxx-xxxx">
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
	
	$(document).on('click','#join-submit-btn',function(){
		if(checkJoinForm()){
			$('#join-form').submit();
		}
	});
	
	function checkJoinForm() {
		var obj = document.getElementById('join-form');
		
		if(obj.email.value == "") {
			obj.email.focus();
			alertify.alert('','E-Mail required');
			return false;
		}		
		if(obj.pwd.value == "") {
			obj.pwd.focus();
			alertify.alert('','Password required');
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