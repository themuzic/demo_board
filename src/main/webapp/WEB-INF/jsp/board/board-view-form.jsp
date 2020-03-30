<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
			<input type="hidden" name="bNo" value="${board.BNo}">
			<input type="hidden" name="wId" value="${loginUser.id}">
			<input type="hidden" name="wName" value="${loginUser.name}">
			<h4 class="ui dividing header" style="padding-bottom: 1em;">
				<span style="font-size: 18px;">${board.BTitle}</span>
				<span class="fr" style="font-size: 14px;">${fn:replace(board.BDate,"T"," ")}</span>
				<br style="clear:both;">
				<span class="nameLine">${board.WName}</span>
				<span class="nameLine fr">조회수&nbsp;&nbsp;&nbsp;&nbsp;${board.BViewCnt}</span>
			</h4>
			${board.BContent}
			<hr style="border-top: 1px solid rgba(34, 36, 38, 0.15);">
		</form>
			<!----------------------------------------------------------->
			
			<div class="ui comments" id="replyDiv"></div>
			<!-- 댓글 입력 textarea -->
			<form class="ui reply form" id="addReplyForm">
				<input type="hidden" name="wId" value="${loginUser.id}">
				<input type="hidden" name="wName" value="${loginUser.name}">
				<input type="hidden" name="rLevel" value="0">
			  <div class="field" style="margin-bottom: 0.5em;">
			    <textarea id="replyArea" name="rContent" style="height: 8em;"></textarea>
			  </div>
			  <div class="ui primary button add-reply-btn" id="">Add Reply</div>
			</form>

			
			<!----------------------------------------------------------->
			
			<div align="center">
				<div class="ui primary button" id="board-modify-btn" tabindex="0">Modify</div>
				<div class="ui button" id="board-remove-btn" tabindex="0">Remove</div>
			</div>
		
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
		location.href="/";
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
		if($(this).hasClass('likeRed')){
			$(this).removeClass('likeRed');
		} else {
			$(this).addClass('likeRed');
		}
	});
	/* 댓글 작성하기 */
	$(document).on('click','.add-reply-btn',function(){
		var replyContent = $(this).prev().children('textarea');
		if(replyContent.val() == ""){
			replyContent.focus();
			alertify.alert('','Comments are required');
		} else{
			var formData = new FormData();
			var obj = this.parentNode;
			formData.append('bNo', ${board.BNo});
			formData.append('wId', obj.wId.value);
			formData.append('wName', obj.wName.value);
			formData.append('rLevel', obj.rLevel.value);
			formData.append('rContent', obj.rContent.value);
			formData.append('rrNo', obj.rrNo.value);
			
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
	/* 대댓글이 있는지 찾아서 있으면 뷰 만들어서 보여주기 */
	function findReply(reply, replyList, $divComment) {
		$.each(replyList, function(index, r){
			if(r.rLevel == 1 && reply.rNo == r.rrNo){
				var $divReply = makeReplyView(reply.wName, r);
				findReply(r, replyList, $divComment).append($divReply);
			}
		});
		return $divComment;
	}
	
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
			 	
			 	var $aLike = $('<span class="likeSpan likeGray" id="like">');
				var $iconLike = $('<i class="heart icon">');
				var $spanLike = $('<span class="likeBlack">').text('${board.BLike}');
			 	$aLike.append($iconLike);
			 	$aLike.append($spanLike);
			 	
			 	/*
			 	var $divLike1 = $('<span class="ui labeled button" tabindex="0">');
				var $divLike2 = $('<span class="ui red button">');
				var $iconLike = $('<i class="heart icon">');
				$divLike2.append($iconLike);
				 var $aLike = $('<a class="ui basic red left pointing label">').text('${board.BLike}'); 
				$divLike1.append($divLike2);
				$divLike1.append($aLike); 
				*/
				
				$h4CommentTitle.append($aLike);
				$replyDiv.append($h4CommentTitle);	
			 	
				if(replyList.length > 0){
					var $spanReplyCount = $('<span class="fl mr20">').text('Comments ('+replyList.length+')');
				 	$h4CommentTitle.append($spanReplyCount);
					
					$.each(replyList, function(index, reply){
						var $divComment0;
						var $divComment1;
						var $divComment2;
						if(reply.rLevel == 0){
							$divComment0 = makeReplyView("", reply);
							$.each(replyList, function(index1, reply1){
								if(reply1.rLevel == 1 && reply.rNo == reply1.rrNo){
									var $divComments1 = $('<div class="comments">');
									$divComment1 = makeReplyView(reply.wName, reply1);
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
		if(reply.rLevel == 1){
			var $to = $('<span class="date">').text(name+"에게 답글");
			$divMetadata.append($to);
		}
		var date = reply.rDate.date.year+'-'+reply.rDate.date.month+'-'+reply.rDate.date.day+' '
					+reply.rDate.time.hour+':'+reply.rDate.time.minute+':'+reply.rDate.time.second;
		var $spanDate = $('<span class="date">').text(date);
		$divMetadata.append($spanDate);
		
		var $divText = $('<div class="text">');
		if(reply.wId == ${loginUser.id}){
			var $pContent = $('<p class="fl" style="margin: 0 0 5px;">').text(reply.rContent);
			var $divBtns = $('<div class="actions fr" id="'+ reply.rNo +'">');
			var $aModify = $('<a class="reply replyModify">').text('Modify');
			var $aRemove = $('<a class="reply replyRemove">').text('Remove');
			
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
		var $formReply = $('<form class="ui reply form re-reply-form" style="display: none;">');
		var $hidden1 = $('<input type="hidden" name="wId" value="'+${loginUser.id}+'">');
		var $hidden2 = $('<input type="hidden" name="wName" value="'+'${loginUser.name}'+'">');
		var $hidden3 = $('<input type="hidden" name="rLevel" value="1">');
		var $hidden4 = $('<input type="hidden" name="rrNo" value="'+reply.rNo+'">');
		var $divReplyField = $('<div class="field" style="margin-bottom: 0.5em;">');
		var $textArea = $('<textarea name="rContent" style="min-height: 4em; height: 4em;">');
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