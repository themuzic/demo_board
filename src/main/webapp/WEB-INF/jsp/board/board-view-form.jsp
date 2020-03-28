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
			
			<div class="ui comments" id="replyDiv">
			  <h4 class="ui dividing header" style="padding-bottom: 1em;">Comments <span id="replyCount"></span></h4>
			  <c:if test="${replyList eq '[]'}">
				<!-- 댓글 -->
				  <div class="comment">
				    <div class="content"><b>이름</b>
				      <div class="metadata">
				        <span class="date">작성일</span>
				      </div>
				      <div class="text">
				        <p class="fl" style="margin: 0 0 5px;">내용</p>
				        <!-- 본인이 작성한 댓글일 경우 수정 삭제 버튼 -->
				        <div class="actions fr">
				        	<a onclick="" id="fix" class="reply">수정</a>
				        	<a class="reply replyRemove">삭제
				        		<input id="hdel" type="hidden" name="tbrId" value="21">
				        	</a>
				        </div>
				        
				      </div>
				      <div class="actions" style="clear: both">
				        <a class="reply openReplyField">Reply</a>
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
				            <a class="reply openReplyField">Reply</a>
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
				    
				    <div class="comment">
				        <div class="content"><b>Jenny Hess</b>
				          <div class="metadata">
				            <span class="date">작성일</span>
				          </div>
				          <div class="text">
				            Elliot you are always so right :)
				          </div>
				          <div class="actions">
				            <a class="reply openReplyField">Reply</a>
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
			  
			  </c:if>
			</div>
			<!-- 댓글 입력 textarea -->
			<form class="ui reply form" id="addReplyForm">
				<input type="hidden" name="wId" value="${loginUser.id}">
				<input type="hidden" name="wName" value="${loginUser.name}">
				<input type="hidden" name="rLevel" value="0">
			  <div class="field" style="margin-bottom: 0.5em;">
			    <textarea id="replyArea" name="rContent" style="height: 8em;"></textarea>
			  </div>
			  <div class="ui primary button" id="main-add-reply-btn">Add Reply</div>
			</form>

			
			<!----------------------------------------------------------->
			
			<div align="center">
				<div class="ui primary button" id="board-modify-btn" tabindex="0">Modify</div>
				<div class="ui button" id="board-remove-btn" tabindex="0">Remove</div>
			</div>
		
	</div>
</body>

<script>
	/* 수정버튼 */
	$(document).on('click','#board-modify-btn',function(){
		$('#board-view-form').submit();
	});
	/* 삭제버튼 */
	$(document).on('click','#board-remove-btn',function(){
		location.href="/";
	});
	/* 대댓글 입력창 열기 */
	$(document).on('click','.openReplyField',function(){
		$(this).next().slideToggle();
	});
	/* 페이지 들어와서 댓글 깔아주기 */
	$(function(){
		getReplyList();
		
	});
	/* 댓글 작성하기 */
	$(document).on('click','#main-add-reply-btn',function(){
		if($('#replyArea').val() == ""){
			$('#replyArea').focus();
			alertify.alert('','Comments are required');
		} else{
			var formData = new FormData();
			var obj = document.getElementById('addReplyForm');
			formData.append('bNo', ${board.BNo});
			formData.append('wId', obj.wId.value);
			formData.append('wName', obj.wName.value);
			formData.append('rLevel', obj.rLevel.value);
			formData.append('rContent', obj.rContent.value);
			
			$.ajax({
				url:"/addReply",
				type:"POST",
				processData:false,
				contentType:false,
				data:formData,
				success:function(data){
					if(data == "success"){
						$('#replyArea').val("");
						getReplyList();
    					
    				} else{
    					alertify.alert('', 'Failure to comment');
    				}
				},
				error:function(){
					alertify.alert('', 'AJAX통신 실패');
				}
			})
			
		}
	});
	/* 해당 게시글의 댓글 목록 불러와서 보여주기*/
	function getReplyList(){
		var bNo= ${board.BNo};
		$.ajax({
			url:"/getReplyList",
			type:"POST",
			data:{bNo:bNo},
			dataType:"json",
			success:function(replyList){
				/* var replyList = JSON.parse(data) */
			 	var $replyDiv = $('#replyDiv');
				$replyDiv.html("");
			 	var $h4CommentTitle = $('<h4 class="ui dividing header" style="padding-bottom: 1em;">');
			 	$replyDiv.append($h4CommentTitle);					
					
				if(replyList.length > 0){
					var $spanReplyCount = $('<span>').text('Comments ('+replyList.length+')');
				 	$h4CommentTitle.append($spanReplyCount);
					
					$.each(replyList, function(index, reply){
						var $divComment0;
						var $divComment1;
						var $divComment2;
						console.log(reply.rDate);
						console.log(reply.rDate.date.year);
						console.log(reply.rDate.date.month);
						console.log(reply.rDate.date.day);
						console.log(reply.rDate.time);
						if(reply.rLevel == 0){
							$divComment0 = makeReplyView("", reply);
							
							$.each(replyList, function(index1, reply1){
								if(reply1.RLevel == 1 && reply.rNo == reply1.rrNo){
									var $divComments1 = $('<div class="comments">');
									$divComment1 = makeReplyView(reply.wName, reply1);
									
									$.each(replyList, function(index2, reply2){
										if(reply2.rLevel == 1 && reply1.rNo == reply2.rrNo){
											var $divComments2 = $('<div class="comments">');
											$divComment2 = makeReplyView(reply1.wName, reply2);
											$divComments2.append($divComment2);
											$divComment1.append($divComments2);
										}
									});
									$divComments1.append($divComment1);
									$divComment0.append($divComments1);
								}
							});
							$replyDiv.append($divComment0);
						}
					});
					
				}else{
					var $spanReplyCount = $('<span>').text('Comments (0)');
				 	$h4CommentTitle.append($spanReplyCount);
				}
			},   /* success:function 끝 */
			error:function(){
				console.log("ajax 통신 실패");
			}
		});
	}
	
	/* 댓글 한개 뷰 만들기 */
	function makeReplyView(name, reply) {
		var $divComment = $('<div class="comment">');
		var $divContent = $('<div class="content">');
		var $bName = $('<b>').text(reply.wName);
		$divContent.append($bName);
		var $divMetadata = $('<div class="metadata">');
		if(reply.RLevel == 1){
			var $to = $('<span class="date">').text(name+"에게 답글");
			$divMetadata.append($to);
		}
		var date = reply.rDate.date.year+'-'+reply.rDate.date.month+'-'+reply.rDate.date.day+' '
					+reply.rDate.time.hour+':'+reply.rDate.time.minute+':'+reply.rDate.time.second;
		console.log('date : '+date);
		var $spanDate = $('<span class="date">').text(date);
		$divMetadata.append($spanDate);
		
		var $divText = $('<div class="text">');
		if(reply.wId == ${loginUser.id}){
			var $pContent = $('<p class="fl" style="margin: 0 0 5px;">').text(reply.rContent);
			var $divBtns = $('<div class="actions fr" id="'+ reply.rNo +'">');
			var $aModify = $('<a class="reply replyModify">').text('수정');
			var $aRemove = $('<a class="reply replyRemove">').text('삭제');
			
			$divBtns.append($aModify);
			$divBtns.append($aRemove);
			$divText.append($pContent);
			$divText.append($divBtns);
			
		} else {
			var $pContent = $('<p>').text(reply.rContent);
			$divText.append($pContent);
		}
		
		var $divActions = $('<div class="actions" style="clear: both">');
		var $aReply = $('<a class="reply openReplyField">').text("Reply");
		var $formReply = $('<form class="ui reply form" style="display: none;">');
		var $hidden1 = $('<input type="hidden" name="wId" value="'+${loginUser.id}+'">');
		var $hidden2 = $('<input type="hidden" name="wName" value="'+'${loginUser.name}'+'">');
		var $hidden3 = $('<input type="hidden" name="rLevel" value="1">');
		var $divReplyField = $('<div class="field" style="margin-bottom: 0.5em;">');
		var $textArea = $('<textarea name="rContent" style="min-height: 4em; height: 4em;">');
		var $addBtn = $('<div class="ui primary button">').text('Add Reply');
		
		$divReplyField.append($textArea);
		$formReply.append($hidden1);
		$formReply.append($hidden2);
		$formReply.append($hidden3);
		$formReply.append($divReplyField);
		$formReply.append($addBtn);
		$divActions.append($aReply);
		$divActions.append($formReply);
		
		$divContent.append($divMetadata);
		$divContent.append($divText);
		$divContent.append($divActions);
		
		$divComment.append($divContent);
		
		return $divComment;		
	}
	
</script>
</html>