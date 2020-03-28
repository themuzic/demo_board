<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<style>
#write-outer {padding: 20px 28% 20px 28%;}
#board-view-form p {
	font-family: "맑은고딕";
	font-size: 15px;
	line-height: 1.6;
	}
.ui.comments {max-width: 100% !important;}
</style>

</head>
<body>
	<jsp:include page="../header/header.jsp"/>
	<div id="write-outer">
		<form class="ui form" id="board-view-form" action="/modify" method="POST">
			<input type="hidden" name="bNo" value="${board.BNo}">
			<input type="hidden" name="wId" value="${loginUser.id}">
			<input type="hidden" name="wName" value="${loginUser.name}">
			<h4 class="ui dividing header" style="padding-bottom: 1em;">
			<span style="font-size: 18px;">${board.BTitle}</span>
			<span class="fr" style="font-size: 14px;">${board.BDate}</span>
			</h4>		
			${board.BContent}
			<hr style="border-top: 1px solid rgba(34, 36, 38, 0.15);">
		</form>
			<!----------------------------------------------------------->
			
			<div class="ui comments">
			  <h4 class="ui dividing header" style="padding-bottom: 1em;">Comments (${replyCount})</h4>
			  <c:if test="${replyList eq '[]'}">
				<!-- 댓글 -->
				  <div class="comment">
				    <div class="content"><b>Elliot Fu</b>
				      <div class="metadata">
				        <span class="date">작성일</span>
				      </div>
				      <div class="text">
				        <p>This has been very useful for my research. Thanks as well!</p>
				      </div>
				      <div class="actions">
				        <a class="reply">Reply</a>
				        <form class="ui reply form" style="display: none;">
					      <div class="field" style="margin-bottom: 0.5em;">
					        <textarea name="rContent" style="min-height: 4em; height: 4em;"></textarea>
					      </div>
					      <div class="ui primary button">Add Reply</div>
					    </form>
				      </div>
				    </div>
					<!-- 대댓글 -->				    
				    <div class="comments">
				      <div class="comment">
				        <div class="content"><b>Jenny Hess</b>
				          <div class="metadata">
				            <span class="date">작성일</span>
				          </div>
				          <div class="text">
				            Elliot you are always so right :)
				          </div>
				          <div class="actions">
				            <a class="reply">Reply</a>
				            <form class="ui reply form" style="display: none;">
						      <div class="field" style="margin-bottom: 0.5em;">
						        <textarea name="rContent" style="min-height: 4em; height: 4em;"></textarea>
						      </div>
						      <div class="ui primary button">Add Reply</div>
						    </form>
				          </div>
				        </div>
				      </div>
				    </div>			    
				  </div>
			  
			  </c:if>
			  <!-- 댓글 입력 textarea -->
			  <form class="ui reply form">
			  	<input type="hidden" name="${loginUser.id}">
			  	<input type="hidden" name="${loginUser.name}">
			    <div class="field" style="margin-bottom: 0.5em;">
			      <textarea name="rContent" style="height: 8em;"></textarea>
			    </div>
			    <div class="ui primary button" id="main-add-reply-btn">Add Reply</div>
			  </form>
			</div>

			
			<!----------------------------------------------------------->
			
			<div align="center">
				<div class="ui primary button" id="board-modify-btn" tabindex="0">Modify</div>
				<div class="ui button" id="board-remove-btn" tabindex="0">Remove</div>
			</div>
		
	</div>
</body>

<script>

	$(document).on('click','#board-modify-btn',function(){
		$('#board-view-form').submit();
	});
	
	$(document).on('click','#board-remove-btn',function(){
		location.href="/";
	});
	
	$(document).on('click','.reply',function(){
		$(this).next().slideToggle();
	});
	
	$(document).on('click','#main-add-reply-btn',function(){
		
	});
	
</script>
</html>