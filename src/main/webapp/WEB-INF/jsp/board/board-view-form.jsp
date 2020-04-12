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
#board-view-form p {
	font-family: "맑은고딕";
	font-size: 15px;
	line-height: 1.6;
	}
.ui.comments {max-width: 100% !important;}
.nameLine {
	line-height: 30px;
    font-weight: 100;
    font-size: 13px;
}
.mr20 {margin-right: 20px;}
.likeSpan {
	border: solid 1px;
	border-color: rgba(34, 36, 38, 0.15);
}
.likeSpan:hover{
	cursor: pointer;
	border-color: red;
}
.likeGray {color: rgba(34, 36, 38, 0.15);}
.likeRed {color: red;}
.likeBlack {
	color: black;
	font-weight: 100;
	}
</style>

</head>
<body>
	<jsp:include page="../header/header.jsp"/>
	<div id="write-outer">
		<form class="ui form" id="board-view-form" action="/modify" method="POST">
			<input type="hidden" name="boardNo" value="${board.boardNo}">
			<input type="hidden" name="writerId" value="${board.writerId}">
			<input type="hidden" name="writerName" value="${board.writerName}">
			<h4 class="ui dividing header" style="padding-bottom: 1em;">
				<span style="font-size: 18px;">${board.boardTitle}</span>
				<span class="fr" style="font-size: 14px;">${fn:replace(board.boardDate,"T"," ")}</span>
				<br style="clear:both;">
				<span class="nameLine">${board.writerName}</span>
				<span class="nameLine fr">조회수&nbsp;&nbsp;&nbsp;&nbsp;${board.boardViewCnt}</span>
			</h4>
			${board.boardContent}
			<hr style="border-top: 1px solid rgba(34, 36, 38, 0.15);">
		</form>
			<!----------------------------------------------------------->
			
			<div class="ui comments" id="replyDiv"></div>
			<!-- 댓글 입력 textarea -->
			<form class="ui reply form" id="addReplyForm">
				<input type="hidden" name="writerId" value="${loginUser.id}">
				<input type="hidden" name="writerName" value="${loginUser.name}">
				<input type="hidden" name="replyLevel" value="0">
			  <div class="field" style="margin-bottom: 0.5em;">
			    <textarea id="replyArea" name="replyContent" style="height: 8em;"></textarea>
			  </div>
			  <div class="ui primary button add-reply-btn" id="">Add Reply</div>
			</form>
			
			<!----------------------------------------------------------->
			<c:if test="${board.writerId eq loginUser.id}">
				<form id="board-remove-form" action="/remove" method="post">
					<div align="center">
						<input type="hidden" name="boardNo" value="${board.boardNo}">
						<div class="ui primary button" id="board-modify-btn" tabindex="0">Modify</div>
						<div class="ui button" id="board-remove-btn" tabindex="0">Remove</div>
					</div>
				</form>
			</c:if>
	</div>
</body>

<script>
	/* 페이지 들어와서 댓글 깔아주기 */
	$(function(){
		getReplyList();
	});
	/* 수정버튼 */
	$(document).on('click','#board-modify-btn',function(){
		$('#board-view-form').submit();
	});
	/* 삭제버튼 */
	$(document).on('click','#board-remove-btn',function(){
		$('#board-remove-form').submit();
	});
	/* 대댓글 입력창 열기 */
	$(document).on('click','.openReplyField',function(){
		var th = $(this).next();
		if(th.css("display") == "none"){
			$(".re-reply-form").slideUp();
			th.slideDown();
		}else{
			th.slideUp();
		}
	});
	/* 좋아요 버튼 누르면 */
	$(document).on('click','#like',function(){
		var count = parseInt($('#likeCount').text());
		var plus;
		if($(this).hasClass('likeRed')){	// 좋아요 -1
			plus = false;
			count -= 1;
		} else {							// 좋아요 +1
			plus = true;
			count += 1;
		}
		likeCount(count, plus);
	});
	/* 댓글 수정 버튼 누르면 */
	$(document).on('click','.replyModify',function(){
		var originText = $(this).parent().prev().text();
		var originHtml = $(this).parents('.text').html();
		
		var form = '<form class="ui form" name="replyModifyForm"><div class="field" style="margin-bottom: 0.5em;">';
		form += '<input type="hidden" name="replyNo">';
		form += '<textarea name="replyContent" style="height: 8em;">';
		form += originText;
		form += '</textarea></div><div class="ui primary button modify-reply-btn">Modify</div>';
		form += '<div class="ui button modify-cancel-btn">Cancel</div></form>';
		$(this).parents('.text').html(form);
	});
	/* 댓글 수정 하기 */
	$(document).on('click','.modify-reply-btn',function(){
		var replyNo = $(this).parents('.text').prev().find('input').val();
		var originText = $(this).siblings('.field').find('textarea').val();
		var formData = new FormData();
		formData.append('replyNo', replyNo);
		formData.append('replyContent', originText);
		console.log(replyNo);
		console.log(originText);
		console.log(formData);
		$.ajax({
			url:"/modifyReply",
			type:"post",
			data:formData,
			contentType:false,
			processData:false,
			success:function(data){
				if(data == 'success'){
					getReplyList();
				} else {
					alertify.alert('', 'Reply Modify failed');
				}
			},
			error:function(){
				alertify.alert('', 'Server connection failed');
			}
		});
	});	
	/* 댓글 수정 취소 */
	$(document).on('click','.modify-cancel-btn',function(){
		var originText = $(this).siblings('.field').find('textarea').text();
		
		var form = '<p class="fl" style="margin: 0 0 5px;">';
		form += originText;
		form += '</p><div class="actions fr" id="62"><a class="reply replyModify">Modify</a>';
		form += '<a class="reply replyRemove">Remove</a></div>';
		$(this).parents('.text').html(form);
	});
	/* 댓글 삭제 버튼 누르면 */
	$(document).on('click','.replyRemove',function(){
		
	});
	/* 좋아요 ajax */
	function likeCount(count, plus){		
		$.ajax({
			url:"/likeCount",
			type:"POST",
			data:{boardNo:${board.boardNo},
				  id:'${loginUser.id}',
				  count:count,
				  plus:plus},
			success:function(updatedCount){
				$('#likeCount').text("");
				$('#likeCount').text(updatedCount);
				if(plus == true) {
					$('#like').addClass('likeRed');
				} else {
					$('#like').removeClass('likeRed');
				}
			},
			error:function(){
				alertify.alert('', 'Server connection failed');
			}
		});
	}	
	/* 댓글 작성하기 */
	$(document).on('click','.add-reply-btn',function(){
		var replyContent = $(this).prev().children('textarea');
		if(replyContent.val() == ""){
			replyContent.focus();
			alertify.alert('','Comments are required');
		} else{
			var formData = new FormData();
			var obj = this.parentNode;
			formData.append('boardNo', ${board.boardNo});
			formData.append('writerId', obj.writerId.value);
			formData.append('writerName', obj.writerName.value);
			formData.append('replyLevel', obj.replyLevel.value);
			formData.append('replyContent', obj.replyContent.value);
			if(obj.rrNo != undefined){
				formData.append('rreplyNo', obj.rreplyNo.value);
			}
			
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
						
						console.log('socket: ', socket);
						// websocket에 메세지 보내기
						socket.send(JSON.stringify({
							cmd:'reply',
							replyWriter:'${loginUser.name}',
							boardWriter:'${board.writerId}',
							boardNo:${board.boardNo}
						}));
						
    				} else{
    					alertify.alert('', 'Failure to comment');
    				}
				},
				error:function(){
					alertify.alert('', 'Server connection failed');
				}
			})
		}
	});
	/* 대댓글이 있는지 찾아서 있으면 뷰 만들어서 보여주기 */
	function findReply(reply, replyList, $divComment) {
		$.each(replyList, function(index, r){
			if(r.replyLevel == 1 && reply.replyNo == r.rreplyNo){
				var $divReply = makeReplyView(reply.writerName, r);
				findReply(r, replyList, $divComment).append($divReply);
			}
		});
		return $divComment;
	}
	/* 해당 게시글의 댓글 목록 불러와서 보여주기*/
	function getReplyList(){
		var boardNo= ${board.boardNo};
		$.ajax({
			url:"/getReplyList",
			type:"POST",
			data:{boardNo:boardNo},
			dataType:"json",
			success:function(replyList){
			 	var $replyDiv = $('#replyDiv');
				$replyDiv.html("");
			 	var $h4CommentTitle = $('<h4 class="ui dividing header" style="padding-bottom: 1em;">');
			 	
			 	var $aLike;
			 	if('${isLike}' == 'true'){
					$aLike = $('<span class="likeSpan likeGray likeRed" id="like">');
				} else {
					$aLike = $('<span class="likeSpan likeGray" id="like">');
				}
			 	
				var $iconLike = $('<i class="heart icon">');
				var $spanLike = $('<span class="likeBlack" id="likeCount">').text('${board.boardLike}');
			 	$aLike.append($iconLike);
			 	$aLike.append($spanLike);
				
				$h4CommentTitle.append($aLike);
				$replyDiv.append($h4CommentTitle);	
			 	
				if(replyList.length > 0){
					var $spanReplyCount = $('<span class="fl mr20">').text('Comments ('+replyList.length+')');
				 	$h4CommentTitle.append($spanReplyCount);
					
					$.each(replyList, function(index, reply){
						var $divComment0;
						var $divComment1;
						var $divComment2;
						if(reply.replyLevel == 0){
							$divComment0 = makeReplyView("", reply);
							$.each(replyList, function(index1, reply1){
								if(reply1.replyLevel == 1 && reply.replyNo == reply1.rreplyNo){
									var $divComments1 = $('<div class="comments">');
									$divComment1 = makeReplyView(reply.writerName, reply1);
									$divComments1.append($divComment1);
									
									$divComment2 = findReply(reply1, replyList, $divComments1);
									
									$divComment0.append($divComment2);
								}
							});
							$replyDiv.append($divComment0);
						}
					});
				}else{
					var $spanReplyCount = $('<span class="fl mr20">').text('Comments (0)');
				 	$h4CommentTitle.append($spanReplyCount);
				}
			},   /* success:function 끝 */
			error:function(){
				console.log("Server connection failed");
			}
		});
	}
	/* 댓글 한개 뷰 만들기 */
	function makeReplyView(name, reply) {
		var $divComment = $('<div class="comment">');
		var $divContent = $('<div class="content">');
		var $bName = $('<b>').text(reply.writerName);
		$divContent.append($bName);
		var $divMetadata = $('<div class="metadata">');
		if(reply.replyLevel == 1){
			var $to = $('<span class="date">').text(name+"에게 답글");
			$divMetadata.append($to);
		}
		var date = reply.replyDate.date.year+'-'+reply.replyDate.date.month+'-'+reply.replyDate.date.day+' '
					+reply.replyDate.time.hour+':'+reply.replyDate.time.minute+':'+reply.replyDate.time.second;
		var $spanDate = $('<span class="date">').text(date);
		var $spanReplyNo = $('<input type="hidden" name="replyNo">').val(reply.replyNo);
		$divMetadata.append($spanDate);
		$divMetadata.append($spanReplyNo);
		
		var $divText = $('<div class="text">');
		if(reply.writerId == ${loginUser.id}){
			var $pContent = $('<p class="fl" style="margin: 0 0 5px;">').text(reply.replyContent);
			var $divBtns = $('<div class="actions fr" id="'+ reply.replyNo +'">');
			var $aModify = $('<a class="reply replyModify">').text('Modify');
			var $aRemove = $('<a class="reply replyRemove">').text('Remove');
			
			$divBtns.append($aModify);
			$divBtns.append($aRemove);
			$divText.append($pContent);
			$divText.append($divBtns);
		} else {
			var $pContent = $('<p>').text(reply.replyContent);
			$divText.append($pContent);
		}
		var $divActions = $('<div class="actions" style="clear: both">');
		var $aReply = $('<a class="reply openReplyField">').text("Reply");
		var $formReply = $('<form class="ui reply form re-reply-form" style="display: none;">');
		var $hidden1 = $('<input type="hidden" name="writerId" value="'+${loginUser.id}+'">');
		var $hidden2 = $('<input type="hidden" name="writerName" value="'+'${loginUser.name}'+'">');
		var $hidden3 = $('<input type="hidden" name="replyLevel" value="1">');
		var $hidden4 = $('<input type="hidden" name="rreplyNo" value="'+reply.replyNo+'">');
		var $divReplyField = $('<div class="field" style="margin-bottom: 0.5em;">');
		var $textArea = $('<textarea name="replyContent" style="min-height: 4em; height: 4em;">');
		var $addBtn = $('<div class="ui primary button add-reply-btn">').text('Add Reply');
		
		$divReplyField.append($textArea);
		$formReply.append($hidden1);
		$formReply.append($hidden2);
		$formReply.append($hidden3);
		$formReply.append($hidden4);
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