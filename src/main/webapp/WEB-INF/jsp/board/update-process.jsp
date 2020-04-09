<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Demo_Board</title>
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
	<form id="process-form" action="/view" method="POST">
		<input type="hidden" name="bNo" value="${board.BNo}">
	</form>
</body>
<script>
	$(function(){
		$('#process-form').submit();
	});
</script>
</html>