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
#outer, #footer {padding: 10px 50px 10px 50px;}
#board, #board td, #board th {
	border-collapse: collapse;
}
#board th {background: #f9f9f9;}
#board tr {
	border-top: 1px solid #f9f9f9;
	border-bottom: 1px solid #f9f9f9;
}
#board td, #board th {text-align: center;}
#board a {color: black;}
#board a:hover {text-decoration: underline;}
table {	
	width: 70%;
	margin: auto;
}
thead tr {height: 45px;}
#bottom, #bottom td {
	border-collapse: collapse;
	border: 1px solid #f9f9f9;
}
#bottom tr {
	height: 40px;
	background-color: #f9f9f9;
}
#bottom a {
	display: inline-block;
	color: black;
	margin: 0 2px;
}
#bottom a:hover {
	text-decoration: underline;
}
#board-body td {height: 35px;}
.pages{
	width: 24px;
    height: 24px;
    line-height: 24px;
    box-sizing: border-box;
}
.currentPage {
	border: 1px solid;
	border-color: #e5e5e5;
    background-color: #fff;
    color: #03c75a;
}
</style>

</head>
<body>
	<jsp:include page="header/header.jsp"/>
	<div id="outer" align="center">
		<table id="board">
			<colgroup>
				<col style="width: 10%;">
				<col style="width: 47%;">
				<col style="width: 11%;">
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
							<td style="text-align: left; padding-left: 40px; padding-right: 40px;">
								<c:if test="${empty loginUser}">
									<c:if test="${board.BReply eq '0'}">
										${board.BTitle}
									</c:if>
									<c:if test="${board.BReply ne '0'}">
										${board.BTitle} <b style="color:red;">[${board.BReply}]</b>
									</c:if>
								</c:if>
								<c:if test="${!empty loginUser}">
									<c:if test="${board.BReply eq '0'}">
										<a href="javascript:viewDetail(${board.BNo});">${board.BTitle}</a>
									</c:if>
									<c:if test="${board.BReply ne '0'}">
										<a href="javascript:viewDetail(${board.BNo});">${board.BTitle}</a> <b style="color:red;">[${board.BReply}]</b>
									</c:if>
									
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
					<div class="field fl">
						<select id="search-select" name="condition1" class="ui fluid dropdown fl" 
							style="height: 35px; margin-left: 3px; border-right: 0;">
							<option value="title">제목</option>
							<option value="writer">작성자</option>
							<option value="content">내용</option>
						</select>
					</div>
					<div class="ui small icon input fr" style="width: 120px;">
					  <input type="text" name="condition2" style="height: 35px; border-radius: 0;">
					  <i class="search icon searchIcon" id="searchIcon" style="pointer-events: auto; cursor: pointer;"></i>
					</div>
				</td>
				<td style="text-align: center;">
					<c:if test="${isFirst eq false}">
						<c:url value="/paging" var="paging">
							<c:param name="pageNum" value="${getNumber}"/>
							<c:param name="condition1" value="${condition1}"/>
							<c:param name="condition2" value="${condition2}"/>
						</c:url>
						<a href="${paging}">〈 이전</a>
					</c:if>
					<c:forEach var="index" begin="${startPage}" end="${lastPage}">
						<c:url value="/paging" var="paging">
							<c:param name="pageNum" value="${index}"/>
							<c:param name="condition1" value="${condition1}"/>
							<c:param name="condition2" value="${condition2}"/>
						</c:url>
						<a href="${paging}" class="pages">${index}</a>
					</c:forEach>
					<c:if test="${isLast eq false}">
						<c:url value="/paging" var="paging">
							<c:param name="pageNum" value="${getNumber+2}"/>
							<c:param name="condition1" value="${condition1}"/>
							<c:param name="condition2" value="${condition2}"/>
						</c:url>
						<a href="${paging}" class="">다음 〉</a>
					</c:if>
				</td>
				<td style="text-align: right;">
					<c:if test="${empty sessionScope.loginUser}"></c:if>
					<c:if test="${!empty sessionScope.loginUser}">
						<button onclick="location.href='/write'" class="mini ui primary button" style="font-size: 12px;">Write</button>
					</c:if>
				</td>
			</tr>
		</table>
	</div>
	
	<jsp:include page="modal/join.jsp"/>
	<jsp:include page="modal/update.jsp"/>

</body>

<script>
	/* 회원가입 버튼 누르면 */
	$(document).on('click','#signUp',function(){
		$("#login-wrap").css("display","none");
		$(".join-wrap").addClass("show");
	});
	/* 회원정보수정 버튼 누르면 */
	$(document).on('click','#modify',function(){
		$("#login-wrap").css("display","none");
		$(".update-wrap").addClass("show");
	});
	/* 로그인 버튼 누르면 */
	$(document).on('click','#signIn',function(){
		$("#login-wrap").slideToggle();
		$('input[name=email]').focus();
		$(".sign").val("");
	});
	/* 회원가입 모달 x 누르면 */
	$(document).on('click','.closeBtn',function(){
		$(".wrap").removeClass("show");
	});
	/* 검색 버튼 누르면 */
	$(document).on('click','#searchIcon',function(){
		var condition1 = $('select[name=condition1]').val();
		var condition2 = $('input[name=condition2]').val();
		location.href='/paging?pageNum=1&condition1='+condition1+'&condition2='+condition2;		
	});
	/* 현재 페이지 표시 */
	$(function(){
		$('#bottom a').each(function(){
			if($(this).text() == '${getNumber+1}'){
				$(this).addClass('currentPage');
			}
		});
		
		if('${condition1}' != '') {
			$('select[name=condition1]').val('${condition1}').prop('selected', true);
		}
		if('${condition2}' != '') {
			$('input[name=condition2]').val('${condition2}');
		}
	});
	/* 게시글 상세 페이지로 이동하는 함수 */
	function viewDetail(b_no) {
		var f = document.viewDetailForm;
		f.bNo.value = b_no;
		f.action = "/view";
		f.method = "post";
		f.submit();
	}
</script>

</html>