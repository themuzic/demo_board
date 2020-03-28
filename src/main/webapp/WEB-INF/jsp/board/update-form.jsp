<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<style>
#write-outer {
	padding: 20px 28% 20px 28%;
	}
</style>

</head>
<body>
	<jsp:include page="../header/header.jsp"/>
	<div id="write-outer">
		<form id="update-form" action="/update" method="POST">
			<input type="hidden" name="bNo" value="">
			<input type="hidden" name="wId" value="${loginUser.id}">
			<input type="hidden" name="wName" value="${loginUser.name}">
			<label>제목</label><br>
			<div class="ui input">
				<input type="text" name="bTitle" style="height: 30px; width: 689px;" value="">
			</div><br><br>		
			<label>내용</label><br>
			<textarea id="summernote" class="summernote" name="bContent" value=""></textarea>
			<div align="center">
				<div class="ui button" id="update-submit-btn" tabindex="0">Modify</div>
				<div class="ui button" id="update-cancel-btn" tabindex="0">Cancel</div>
			</div>
		</form>
	</div>
</body>

<script>
	$(document).ready(function() { 
		$("#summernote").summernote({
			tabsize: 2,
	        height: 300,
	        lang: 'ko-KR'
		});
		$('.dropdown-toggle').dropdown();
	});
	
	$(document).on('click','#update-submit-btn',function(){
		if(checkWriteForm()) {
			$('#update-form').submit();
		}
	});
	
	$(document).on('click','#update-cancel-btn',function(){
		location.href="/";
	});
	
	function checkWriteForm() {
		var obj = document.getElementById('update-form');
		
		if(obj.bTitle.value == ""){
			obj.bTitle.focus();
			alertify.alert('','Title is empty');
			return false;
		}
		if(obj.bContent.value == "") {
			obj.bContent.focus();
			alertify.alert('','Content is empty');
			return false;
		}
		return true;
	}
	
</script>
</html>