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
#write-outer {padding: 10px 28% 20px 28%;}
</style>

</head>
<body>
	<jsp:include page="../header/header.jsp"/>
	<div id="write-outer">
		<form id="write-form" action="/insert" method="POST">
			<input type="hidden" name="wId" value="${loginUser.id}">
			<input type="hidden" name="wName" value="${loginUser.name}">
			<label>제목</label><br>
			<div class="ui input">
				<input type="text" name="bTitle" style="height: 30px; width: 689px;">
			</div><br><br>		
			<label>내용</label><br>
			<textarea id="summernote" class="summernote" name="bContent" value=""></textarea>
			<div align="center">
				<div class="ui primary button" id="write-submit-btn" tabindex="0">Write</div>
				<div class="ui button" id="write-cancel-btn" tabindex="0">Cancel</div>
			</div>
		</form>
	</div>
</body>

<script>
	/* 썸머노트 활성화 */
	$(document).ready(function() { 
		$("#summernote").summernote({
			tabsize: 2,
	        height: 300,
	        lang: 'ko-KR'
		});
		$('.dropdown-toggle').dropdown();
	});
	/* 글 작성 버튼 누르면 */
	$(document).on('click','#write-submit-btn',function(){
		if(checkWriteForm()) {
			/* 
			var text = $('#summernote').val();
			text = replaceContext(text);
			$('#summernote').val(text);
			 */
			$('#write-form').submit();
		}
	});
	/* 취소 버튼 누르면 */
	$(document).on('click','#write-cancel-btn',function(){
		location.href="/";
	});
	/* 썸머노트에 작성한 내용 DB에 저장하기전에 HTML태그들 제거하는 함수 */
	/* 
	function replaceContext(text){
		text = text.replace(/<br\/>/ig, "\n");
		text = text.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "");
		return text;
	}
	 */
	/* 글 작성 하기전에 검사 */
	function checkWriteForm() {
		var obj = document.getElementById('write-form');
		
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