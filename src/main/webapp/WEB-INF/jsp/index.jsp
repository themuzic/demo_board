<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Demo_Board</title>

<style type="text/css">
.fl {float: left;}
.fr {float: right;}
#outer, #footer {padding: 20px 50px 20px 50px;}
#board, #board td {
	border-collapse: collapse;
	border: 1px solid black;
}
#board td {text-align: center;}
table {	
	width: 60%;
	margin: auto;
	}
thead tr {height: 40px;}
#bottom, #bottom td {
	border-collapse: collapse;
	border: 1px solid black;
}
#bottom tr {height: 30px;}
</style>

</head>
<body>
	<jsp:include page="header/header.jsp"/>
	<div id="outer" align="center">
		<table id="board">
			<colgroup>
				<col style="width: 15%;">
				<col style="width: 50%;">
				<col style="width: 15%;">
				<col style="width: 20%;">
			</colgroup>
			<thead>
				<tr>
					<td>글번호</td>
					<td>제목</td>
					<td>작성자</td>
					<td>작성일</td>
				</tr>
			</thead>
			<tbody>
					
			</tbody>
		</table>		
	</div>
	<div id="footer">
		<table id="bottom">
			<colgroup>
				<col style="width: 20%;">
				<col style="width: 60%;">
				<col style="width: 20%;">
			</colgroup>
			<tr>
				<td>
					<select id="search-select" class="fl">
						<option value="title">제목</option>
						<option value="writer">작성자</option>
						<option value="content">내용</option>
					</select>
					<input type="text" id="search-keyword" class="fl" size="10">
				</td>
				<td style="text-align: center;">페이징부</td>
				<td style="text-align: right;">
					<button onclick="location.href='/write'">글쓰기</button>
				</td>
			</tr>
		</table>
	</div>
	
	<jsp:include page="modal/join.jsp"/>

</body>

<script>
	// 회원가입 버튼 누르면
	$(document).on('click','#signUp',function(){
		$("#login-wrap").css("display","none");
		$(".join-wrap").addClass("show");
	});
	
	// 로그인 버튼 누르면
	$(document).on('click','#signIn',function(){
		$("#login-wrap").slideToggle();
		$(".sign").val("");
	});
	
	// 회원가입 모달 x 누르면
	$(document).on('click','.closeBtn',function(){
		$(".join-wrap").removeClass("show");
	});
</script>

</html>