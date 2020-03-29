<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Demo_Board</title>

<style type="text/css">
#outer, #footer {padding: 20px 50px 20px 50px;}
#board, #board td, #board th {
	border-collapse: collapse;
	border: 1px solid black;
}
#board td, #board th {text-align: center;}
table {	
	width: 70%;
	margin: auto;
	}
thead tr {height: 45px;}
#bottom, #bottom td {
	border-collapse: collapse;
	border: 1px solid black;
}
#bottom tr {height: 30px;}
#board-body td {height: 35px;}
</style>

</head>
<body>
	<jsp:include page="header/header.jsp"/>
	<div id="outer" align="center">
		<table id="board">
			<colgroup>
				<col style="width: 10%;">
				<col style="width: 45%;">
				<col style="width: 13%;">
				<col style="width: 16%;">
				<col style="width: 8%;">
				<col style="width: 8%;">
			</colgroup>
			<thead>
				<tr>
					<th>글번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>좋아요</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody id="board-body">
				<c:if test="${boardList ne '[]'}">
					<c:forEach var="board" items="${boardList}">
						<tr>
							<td>${board.BNo}</td>
							<td align="left">
								<c:if test="${empty loginUser}">
									${board.BTitle}
								</c:if>
								<c:if test="${!empty loginUser}">
									<a href="javascript:viewDetail(${board.BNo});">${board.BTitle}</a>
								</c:if>
							</td>
							<td>${board.WName}</td>
							<td>${fn:replace(board.BDate,"T"," ")}</td>
							<td>${board.BLike}</td>
							<td>${board.BViewCnt}</td>
						</tr>
					</c:forEach>
				</c:if >
			</tbody>
		</table>		
	</div>
	<div id="footer">
		<form name="viewDetailForm">
			<input type="hidden" name="bNo">
		</form>
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
				<td style="text-align: center;">
				페이징부
				
				
				</td>
				<td style="text-align: right;">
					<c:if test="${empty sessionScope.loginUser}">
						
					</c:if>
					<c:if test="${!empty sessionScope.loginUser}">
						<button onclick="location.href='/write'">글쓰기</button>
					</c:if>
				</td>
			</tr>
		</table>
	</div>
	
	<jsp:include page="modal/join.jsp"/>
	<jsp:include page="modal/update.jsp"/>

</body>

<script>
	// 회원가입 버튼 누르면
	$(document).on('click','#signUp',function(){
		$("#login-wrap").css("display","none");
		$(".join-wrap").addClass("show");
	});
	// 회원정보수정 버튼 누르면
	$(document).on('click','#modify',function(){
		$("#login-wrap").css("display","none");
		$(".update-wrap").addClass("show");
	});
	
	// 로그인 버튼 누르면
	$(document).on('click','#signIn',function(){
		$("#login-wrap").slideToggle();
		$(".sign").val("");
	});
	
	// 회원가입 모달 x 누르면
	$(document).on('click','.closeBtn',function(){
		$(".wrap").removeClass("show");
	});
	
	function viewDetail(b_no) {
		var f = document.viewDetailForm;
		f.bNo.value = b_no;
		f.action = "/view";
		f.method = "post";
		f.submit();
	}
	
	$(function(){
		console.log('boardList: '+'${boardList}');
		console.log('prevPage: '+'${prevPage}');
		console.log('nextPage: '+'${nextPage}');
		console.log('getNumber: '+'${getNumber}');
		console.log('getNumberOfElements: '+'${getNumberOfElements}');
		console.log('getSize: '+'${getSize}');
		console.log('isFirst: '+'${isFirst}');
		console.log('isLast: '+'${isLast}');
	});
	
</script>

</html>