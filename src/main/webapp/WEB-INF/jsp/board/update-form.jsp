<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Demo_Board</title>
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<style>
#write-outer {padding: 10px 28% 20px 28%;}
</style>

</head>
<body>
	<jsp:include page="../header/header.jsp"/>
	<div id="write-outer">
		<form id="update-form" action="/update" method="POST">
			<input type="hidden" name="boardNo" value="${board.boardNo}">
			<input type="hidden" name="writerId" value="${board.writerId}">
			<input type="hidden" name="writerName" value="${board.writerName}">
			<%-- <input type="hidden" name="boardDate" value="${fn:replace(board.boardDate,'T',' ')}"> --%>
			<label>제목</label><br>
			<div class="ui input">
				<input type="text" name="boardTitle" style="height: 30px; width: 689px;" value="${board.boardTitle}">
			</div><br><br>		
			<label>내용</label><br>
			<textarea id="summernote" class="summernote" name="boardContent" value=""></textarea>
			<div align="center">
				<div class="ui primary button" id="update-submit-btn" tabindex="0">Modify</div>
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
		/* 썸머노트에 원래 글 내용 띄우기 */
		$("#summernote").summernote('code','${board.boardContent}');
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
		
		if(obj.boardTitle.value == ""){
			obj.boardTitle.focus();
			alertify.alert('','Title is empty');
			return false;
		}
		if(obj.boardContent.value == "") {
			obj.boardContent.focus();
			alertify.alert('','Content is empty');
			return false;
		}
		return true;
	}
	
</script>
</html>